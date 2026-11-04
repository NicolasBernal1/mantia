import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/core/order_rules.dart';
import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/order_status.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/repositories/auth_repository.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/widgets/empty_view.dart';
import 'package:mantia/widgets/error_view.dart';
import 'package:mantia/widgets/info_chip.dart';
import 'package:mantia/widgets/loading_view.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;
  final UserProfile profile;
  final AuthRepository authRepository;
  final OrderRepository orderRepository;

  const OrderDetailPage({
    super.key,
    required this.orderId,
    required this.profile,
    required this.authRepository,
    required this.orderRepository,
  });

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _causeController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _closeResultController = TextEditingController();

  late Future<MaintenanceOrder?> _futureOrder;
  late Future<List<UserProfile>> _futureTechnicians;

  String _selectedPriority = OrderPriority.medium;
  UserProfile? _selectedTechnician;
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _futureOrder = _loadOrder();
    _futureTechnicians = widget.profile.role == UserRole.supervisor
        ? widget.authRepository.getTechnicians()
        : Future.value(<UserProfile>[]);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _reasonController.dispose();
    _causeController.dispose();
    _costController.dispose();
    _closeResultController.dispose();
    super.dispose();
  }

  Future<MaintenanceOrder?> _loadOrder() async {
    final order = await widget.orderRepository.getOrder(
      widget.profile.uid,
      widget.orderId,
    );
    if (order != null && _descriptionController.text.isEmpty) {
      _descriptionController.text = order.description;
    }
    return order;
  }

  void reloadOrder() {
    setState(() {
      _futureOrder = _loadOrder();
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _runAction(
    Future<void> Function() action,
    String successMessage,
  ) async {
    if (_isBusy) return;
    setState(() => _isBusy = true);

    try {
      await action();
      _showMessage(successMessage);
      if (mounted) reloadOrder();
    } on AppException catch (error) {
      _showMessage(error.message);
    } catch (error, stackTrace) {
      AppLogger.unexpected(
        'Fallo inesperado en una accion de la orden',
        error,
        stackTrace,
      );
      _showMessage('Ocurrió un error inesperado. Inténtalo de nuevo.');
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  void saveDescription(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.editDescription(
        ownerUid: widget.profile.uid,
        orderId: order.id,
        description: _descriptionController.text,
      ),
      'Cambio guardado en el dispositivo (pendiente de sincronizar).',
    );
  }

  void sendNow(MaintenanceOrder order) {
    _runAction(() async {
      await widget.orderRepository.sendOrder(widget.profile.uid, order.id);
      final updatedOrder = await widget.orderRepository.getOrder(
        widget.profile.uid,
        order.id,
      );
      if (updatedOrder != null && updatedOrder.pendingSync) {
        throw AppException(
          updatedOrder.syncError ?? 'Sigue pendiente. Revisa tu conexión.',
        );
      }
    }, 'Solicitud sincronizada con el servidor.');
  }

  void discardChange(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.discardLocalChange(
        widget.profile.uid,
        order.id,
      ),
      'Cambio local descartado.',
    );
  }

  void authorize(MaintenanceOrder order) {
    final technician = _selectedTechnician;
    if (technician == null) {
      _showMessage('Elige el técnico que se asignará a la orden.');
      return;
    }
    _runAction(
      () => widget.orderRepository.authorize(
        profile: widget.profile,
        orderId: order.id,
        priority: _selectedPriority,
        technician: technician,
      ),
      'Orden autorizada y activo asignado.',
    );
  }

  void reject(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.reject(
        profile: widget.profile,
        orderId: order.id,
        reason: _reasonController.text,
      ),
      'Orden rechazada.',
    );
  }

  void closeOrder(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.close(
        profile: widget.profile,
        orderId: order.id,
        result: _closeResultController.text,
      ),
      'Orden cerrada. El activo quedó libre.',
    );
  }

  void registerDiagnosis(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.registerDiagnosis(
        profile: widget.profile,
        orderId: order.id,
        cause: _causeController.text,
        cost: OrderRules.parseCost(_costController.text),
      ),
      'Diagnóstico registrado.',
    );
  }

  void startRepair(MaintenanceOrder order) {
    final problem = OrderRules.checkCanStartRepair(order);
    if (problem != null) {
      _showMessage(problem);
      return;
    }
    _runAction(
      () => widget.orderRepository.startRepair(
        profile: widget.profile,
        orderId: order.id,
      ),
      'Reparación iniciada.',
    );
  }

  void finishRepair(MaintenanceOrder order) {
    _runAction(
      () => widget.orderRepository.finishRepair(
        profile: widget.profile,
        orderId: order.id,
      ),
      'Trabajo reportado como terminado.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle de la orden'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<MaintenanceOrder?>(
          future: _futureOrder,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingView();
            }

            if (snapshot.hasError) {
              return ErrorView(
                message: 'No pudimos leer la orden',
                onRetry: reloadOrder,
              );
            }

            final order = snapshot.data;
            if (order == null) {
              return const EmptyView(
                message: 'Esta orden ya no está disponible',
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: _buildOrder(order),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrder(MaintenanceOrder order) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          order.assetName,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Text('Código ${order.assetCode}'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            InfoChip(
              icon: Icons.flag_outlined,
              label: OrderStatus.label(order.status),
            ),
            InfoChip(
              icon: order.pendingSync
                  ? Icons.cloud_upload_outlined
                  : Icons.cloud_done_outlined,
              label: order.pendingSync
                  ? 'Pendiente de sincronizar'
                  : 'Sincronizada',
              backgroundColor: order.pendingSync
                  ? colors.tertiaryContainer
                  : colors.surfaceContainerHighest,
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (order.pendingSync) _buildSyncBanner(order),
        const Divider(),
        const SizedBox(height: 8),
        _buildInfo('Descripción de la falla', order.description),
        _buildInfo('Solicitante', order.requesterName),
        _buildInfo(
          'Prioridad',
          order.priority == null ? null : OrderPriority.label(order.priority!),
        ),
        _buildInfo('Técnico asignado', order.technicianName),
        _buildInfo('Causa (diagnóstico)', order.diagnosisCause),
        _buildInfo(
          'Costo estimado',
          order.estimatedCost == null
              ? null
              : OrderRules.formatMoney(order.estimatedCost!) +
                    (order.isOverBudget ? ' (supera el presupuesto)' : ''),
        ),
        _buildInfo('Verificación de cierre', order.closeResult),
        _buildInfo('Motivo de rechazo', order.rejectionReason),
        ..._buildActions(order),
        if (_isBusy)
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildInfo(String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSyncBanner(MaintenanceOrder order) {
    final colors = Theme.of(context).colorScheme;
    final hasError = order.syncError != null;

    return Card(
      color: hasError ? colors.errorContainer : colors.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hasError ? 'No se pudo sincronizar' : 'Pendiente de sincronizar',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              hasError
                  ? order.syncError!
                  : 'Este cambio solo existe en tu dispositivo. Mientras no se '
                        'sincronice, supervisión no lo ve ni puede autorizarlo.',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _isBusy ? null : () => sendNow(order),
                  child: const Text('Sincronizar ahora'),
                ),
                if (hasError)
                  OutlinedButton(
                    onPressed: _isBusy ? null : () => discardChange(order),
                    child: const Text('Descartar cambio local'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildActions(MaintenanceOrder order) {
    switch (widget.profile.role) {
      case UserRole.requester:
        return _buildRequesterActions(order);
      case UserRole.supervisor:
        return _buildSupervisorActions(order);
      case UserRole.technician:
        return _buildTechnicianActions(order);
      default:
        return [];
    }
  }

  List<Widget> _sectionTitle(String title) {
    return [
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 16),
      Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 12),
    ];
  }

  List<Widget> _buildRequesterActions(MaintenanceOrder order) {
    final isOwnRequest = order.requesterUid == widget.profile.uid;
    if (!isOwnRequest || order.status != OrderStatus.requested) return [];

    return [
      ..._sectionTitle('Editar descripción'),
      TextField(
        controller: _descriptionController,
        minLines: 2,
        maxLines: 5,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Descripción de la falla',
        ),
      ),
      const SizedBox(height: 12),
      ElevatedButton(
        onPressed: _isBusy ? null : () => saveDescription(order),
        child: const Text('Guardar cambio'),
      ),
    ];
  }

  List<Widget> _buildSupervisorActions(MaintenanceOrder order) {
    final colors = Theme.of(context).colorScheme;
    final widgets = <Widget>[];

    if (order.status == OrderStatus.requested) {
      widgets.addAll([
        ..._sectionTitle('Autorizar'),
        const Text('Prioridad'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: OrderPriority.all.map((priority) {
            return ChoiceChip(
              label: Text(OrderPriority.label(priority)),
              selected: _selectedPriority == priority,
              onSelected: (_) {
                setState(() {
                  _selectedPriority = priority;
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const Text('Técnico asignado'),
        const SizedBox(height: 8),
        _buildTechnicianChoices(),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _isBusy ? null : () => authorize(order),
          child: const Text('Autorizar'),
        ),
        ..._sectionTitle('Rechazar solicitud'),
        _buildReasonField(),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: _isBusy ? null : () => reject(order),
          child: const Text('Rechazar'),
        ),
      ]);
    }

    if (order.status == OrderStatus.diagnosed && order.isOverBudget) {
      widgets.addAll([
        ..._sectionTitle('Rechazar por presupuesto'),
        Text(
          'El costo estimado (${OrderRules.formatMoney(order.estimatedCost!)}) supera el '
          'presupuesto de ${OrderRules.formatMoney(OrderRules.repairBudget)}. '
          'Debes rechazar la orden antes de que inicie la reparación.',
          style: TextStyle(color: colors.error),
        ),
        const SizedBox(height: 12),
        _buildReasonField(),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _isBusy ? null : () => reject(order),
          child: const Text('Rechazar por presupuesto'),
        ),
      ]);
    }

    if (order.status == OrderStatus.finished) {
      widgets.addAll([
        ..._sectionTitle('Verificar y cerrar'),
        TextField(
          controller: _closeResultController,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Resultado de tu verificación',
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _isBusy ? null : () => closeOrder(order),
          child: const Text('Cerrar orden'),
        ),
      ]);
    }

    return widgets;
  }

  Widget _buildReasonField() {
    return TextField(
      controller: _reasonController,
      minLines: 2,
      maxLines: 4,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Motivo del rechazo',
      ),
    );
  }

  Widget _buildTechnicianChoices() {
    return FutureBuilder<List<UserProfile>>(
      future: _futureTechnicians,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        if (snapshot.hasError) {
          return TextButton.icon(
            onPressed: () {
              setState(() {
                _futureTechnicians = widget.authRepository.getTechnicians();
              });
            },
            icon: const Icon(Icons.refresh),
            label: const Text(
              'No se pudo cargar la lista de técnicos. Reintentar',
            ),
          );
        }

        final technicians = snapshot.data ?? [];
        if (technicians.isEmpty) {
          return const Text(
            'No hay técnicos registrados. Asigna el rol "tecnico" a una cuenta '
            'desde Firebase Console.',
          );
        }

        return Wrap(
          spacing: 8,
          children: technicians.map((technician) {
            return ChoiceChip(
              label: Text(technician.displayName),
              selected: _selectedTechnician?.uid == technician.uid,
              onSelected: (_) {
                setState(() {
                  _selectedTechnician = technician;
                });
              },
            );
          }).toList(),
        );
      },
    );
  }

  List<Widget> _buildTechnicianActions(MaintenanceOrder order) {
    if (order.technicianUid != widget.profile.uid) return [];

    if (order.status == OrderStatus.authorized) {
      return [
        ..._sectionTitle('Diagnóstico'),
        TextField(
          controller: _causeController,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Causa de la falla',
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _costController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Costo estimado (COP)',
            helperText:
                'Presupuesto permitido: ${OrderRules.formatMoney(OrderRules.repairBudget)}',
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _isBusy ? null : () => registerDiagnosis(order),
          child: const Text('Registrar diagnóstico'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: _isBusy ? null : () => startRepair(order),
          child: const Text('Iniciar reparación'),
        ),
      ];
    }

    if (order.status == OrderStatus.diagnosed) {
      return [
        ..._sectionTitle('Reparación'),
        ElevatedButton(
          onPressed: _isBusy ? null : () => startRepair(order),
          child: const Text('Iniciar reparación'),
        ),
      ];
    }

    if (order.status == OrderStatus.inRepair) {
      return [
        ..._sectionTitle('Reparación'),
        ElevatedButton(
          onPressed: _isBusy ? null : () => finishRepair(order),
          child: const Text('Reportar trabajo terminado'),
        ),
      ];
    }

    return [];
  }
}
