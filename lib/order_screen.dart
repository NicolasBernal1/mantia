import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/asset_screen.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/order_card.dart';
import 'package:mantia/order_detail.dart';
import 'package:mantia/repositories/asset_repository.dart';
import 'package:mantia/repositories/auth_repository.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/widgets/empty_view.dart';
import 'package:mantia/widgets/error_view.dart';
import 'package:mantia/widgets/loading_view.dart';
import 'package:mantia/widgets/session_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  final UserProfile profile;
  final AuthRepository authRepository;
  final AssetRepository assetRepository;
  final OrderRepository orderRepository;

  const OrderScreen({
    super.key,
    required this.profile,
    required this.authRepository,
    required this.assetRepository,
    required this.orderRepository,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  static const Map<String, String> _filterNames = {
    'open': 'Abiertas',
    'closed': 'Finalizadas',
    'unsynced': 'Pendientes de sync',
    'all': 'Todas',
  };

  late Future<List<MaintenanceOrder>> _futureOrders;
  String _selectedFilter = 'open';
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _futureOrders = widget.orderRepository.getOrders(widget.profile);
    _loadFilter();
    _refreshInBackground();
  }

  void reloadOrders() {
    setState(() {
      _futureOrders = widget.orderRepository.getOrders(widget.profile);
    });
  }

  Future<void> _refreshInBackground() async {
    try {
      await widget.orderRepository.syncWithServer(widget.profile);
    } catch (error, stackTrace) {
      AppLogger.error(
        'No se pudo actualizar desde el servidor',
        error,
        stackTrace,
      );
    }
    if (!mounted) return;
    reloadOrders();
  }

  Future<void> saveFilter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ordersFilter', _selectedFilter);
  }

  Future<void> _loadFilter() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _selectedFilter = prefs.getString('ordersFilter') ?? 'open';
    });
  }

  void selectFilter(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    saveFilter();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> syncNow() async {
    if (_isSyncing) return;
    setState(() => _isSyncing = true);

    try {
      final pendingCount = await widget.orderRepository.syncWithServer(
        widget.profile,
      );
      _showMessage(
        pendingCount == 0
            ? 'Todo quedó sincronizado.'
            : 'Quedan $pendingCount pendiente(s). Revisa tu conexión y vuelve a intentar.',
      );
    } on AppException catch (error) {
      _showMessage(error.message);
    } catch (error, stackTrace) {
      AppLogger.unexpected(
        'Fallo inesperado al sincronizar',
        error,
        stackTrace,
      );
      _showMessage('No se pudo sincronizar. Inténtalo de nuevo.');
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
        reloadOrders();
      }
    }
  }

  Future<void> openOrderDetail(MaintenanceOrder order) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderDetailPage(
          orderId: order.id,
          profile: widget.profile,
          authRepository: widget.authRepository,
          orderRepository: widget.orderRepository,
        ),
      ),
    );
    if (!mounted) return;
    reloadOrders();
  }

  void openAssets() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssetScreen(
          profile: widget.profile,
          authRepository: widget.authRepository,
          assetRepository: widget.assetRepository,
          orderRepository: widget.orderRepository,
        ),
      ),
    );
  }

  List<MaintenanceOrder> _applyFilter(List<MaintenanceOrder> orders) {
    switch (_selectedFilter) {
      case 'open':
        return orders.where((order) => !order.isFinished).toList();
      case 'closed':
        return orders.where((order) => order.isFinished).toList();
      case 'unsynced':
        return orders.where((order) => order.pendingSync).toList();
      default:
        return orders;
    }
  }

  String get _title {
    switch (widget.profile.role) {
      case UserRole.supervisor:
        return 'Supervisión';
      case UserRole.technician:
        return 'Bandeja técnica';
      default:
        return 'Mis solicitudes';
    }
  }

  @override
  Widget build(BuildContext context) {
    final canOpenAssets = widget.profile.role == UserRole.supervisor;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: [
          if (canOpenAssets)
            IconButton(
              tooltip: 'Activos',
              icon: const Icon(Icons.inventory_2_outlined),
              onPressed: openAssets,
            ),
          IconButton(
            tooltip: 'Sincronizar',
            icon: const Icon(Icons.sync),
            onPressed: _isSyncing ? null : syncNow,
          ),
          SessionMenu(
            profile: widget.profile,
            authRepository: widget.authRepository,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<List<MaintenanceOrder>>(
      future: _futureOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (snapshot.hasError) {
          return ErrorView(
            message: 'No pudimos leer las órdenes guardadas',
            onRetry: reloadOrders,
          );
        }

        final allOrders = snapshot.data ?? [];
        final shownOrders = _applyFilter(allOrders);
        final pendingCount = allOrders
            .where((order) => order.pendingSync)
            .length;

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: shownOrders.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: _filterNames.entries.map((entry) {
                        return ChoiceChip(
                          label: Text(entry.value),
                          selected: _selectedFilter == entry.key,
                          onSelected: (_) {
                            selectFilter(entry.key);
                          },
                        );
                      }).toList(),
                    ),
                    if (pendingCount > 0) ...[
                      const SizedBox(height: 12),
                      Text(
                        '$pendingCount orden(es) pendiente(s) de sincronizar. '
                        'Toca el icono de sincronizar para reintentar.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                    if (shownOrders.isEmpty) ...[
                      const SizedBox(height: 48),
                      const EmptyView(
                        message: 'No hay órdenes para este filtro',
                      ),
                    ],
                  ],
                ),
              );
            }

            final order = shownOrders[index - 1];
            return OrderCard(
              order: order,
              onTap: () {
                openOrderDetail(order);
              },
            );
          },
        );
      },
    );
  }
}
