import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/asset_card.dart';
import 'package:mantia/asset_detail.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/models/office_asset.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/order_screen.dart';
import 'package:mantia/repositories/asset_repository.dart';
import 'package:mantia/repositories/auth_repository.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/widgets/empty_view.dart';
import 'package:mantia/widgets/error_view.dart';
import 'package:mantia/widgets/loading_view.dart';
import 'package:mantia/widgets/session_menu.dart';

class AssetScreen extends StatefulWidget {
  final UserProfile profile;
  final AuthRepository authRepository;
  final AssetRepository assetRepository;
  final OrderRepository orderRepository;

  const AssetScreen({
    super.key,
    required this.profile,
    required this.authRepository,
    required this.assetRepository,
    required this.orderRepository,
  });

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  late Future<List<OfficeAsset>> _futureAssets;
  Set<String>? _occupiedAssetIds;

  @override
  void initState() {
    super.initState();
    _futureAssets = widget.assetRepository.getAssets();
    _loadOccupiedAssetIds();
  }

  void retryAssetList() {
    setState(() {
      _futureAssets = widget.assetRepository.getAssets();
    });
    _loadOccupiedAssetIds();
  }

  Future<void> _loadOccupiedAssetIds() async {
    try {
      final occupiedIds = await widget.assetRepository.getOccupiedAssetIds();
      if (!mounted) return;
      setState(() {
        _occupiedAssetIds = occupiedIds;
      });
    } catch (error, stackTrace) {
      AppLogger.error(
        'No se pudo consultar la disponibilidad',
        error,
        stackTrace,
      );
    }
  }

  void openAssetDetail(OfficeAsset asset) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AssetDetailPage(
          asset: asset,
          isOccupied: _occupiedAssetIds?.contains(asset.id),
          profile: widget.profile,
          orderRepository: widget.orderRepository,
        ),
      ),
    );
  }

  void openOrders() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderScreen(
          profile: widget.profile,
          authRepository: widget.authRepository,
          assetRepository: widget.assetRepository,
          orderRepository: widget.orderRepository,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRequester = widget.profile.role == UserRole.requester;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Mantia'),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: isRequester ? 'Mis solicitudes' : 'Órdenes',
            icon: const Icon(Icons.assignment_outlined),
            onPressed: openOrders,
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
    return FutureBuilder<List<OfficeAsset>>(
      future: _futureAssets,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (snapshot.hasError) {
          return ErrorView(
            message: 'No pudimos cargar los activos',
            onRetry: retryAssetList,
          );
        }

        final assets = snapshot.data ?? [];

        if (assets.isEmpty) {
          return const EmptyView(message: 'No se encontraron activos');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: assets.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Activos de la oficina',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${assets.length} activos registrados',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Toca un activo para ver su detalle y reportar una falla.',
                    ),
                  ],
                ),
              );
            }

            final asset = assets[index - 1];
            return AssetCard(
              asset: asset,
              isOccupied: _occupiedAssetIds?.contains(asset.id),
              onTap: () {
                openAssetDetail(asset);
              },
            );
          },
        );
      },
    );
  }
}
