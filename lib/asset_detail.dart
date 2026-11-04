import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/models/office_asset.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/widgets/info_chip.dart';

class AssetDetailPage extends StatefulWidget {
  final OfficeAsset asset;
  final bool? isOccupied;
  final UserProfile profile;
  final OrderRepository orderRepository;

  const AssetDetailPage({
    super.key,
    required this.asset,
    required this.isOccupied,
    required this.profile,
    required this.orderRepository,
  });

  @override
  State<AssetDetailPage> createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _saveRequest() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    try {
      await widget.orderRepository.createRequest(
        profile: widget.profile,
        asset: widget.asset,
        description: _descriptionController.text,
      );
      if (!mounted) return;
      _descriptionController.clear();
      _showMessage(
        'Solicitud guardada en el dispositivo (pendiente de sincronizar). '
        'Revisa su estado en "Mis solicitudes".',
      );
    } on AppException catch (error) {
      _showMessage(error.message);
    } catch (error, stackTrace) {
      AppLogger.unexpected(
        'No se pudo guardar la solicitud',
        error,
        stackTrace,
      );
      _showMessage('No se pudo guardar la solicitud.');
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final asset = widget.asset;
    final isRequester = widget.profile.role == UserRole.requester;

    return Scaffold(
      backgroundColor: colors.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Detalle del activo'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Wrap permite que las etiquetas bajen en pantallas pequeñas.
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      InfoChip(
                        icon: Icons.category_outlined,
                        label: asset.type,
                      ),
                      InfoChip(icon: Icons.tag, label: asset.internalCode),
                      if (widget.isOccupied != null)
                        InfoChip(
                          icon: widget.isOccupied!
                              ? Icons.build_outlined
                              : Icons.check_circle_outline,
                          label: widget.isOccupied!
                              ? 'Ocupado (orden activa)'
                              : 'Disponible',
                          backgroundColor: widget.isOccupied!
                              ? colors.tertiaryContainer
                              : colors.surfaceContainerHighest,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ubicación',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    asset.location,
                    style: TextStyle(
                      fontSize: 16,
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  if (isRequester) ...[
                    const Text(
                      'Reportar falla',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      minLines: 2,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Describe la falla',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _isSaving ? null : _saveRequest,
                      child: const Text('Guardar solicitud'),
                    ),
                  ] else
                    Text(
                      'Solo los solicitantes reportan fallas. Aquí puedes consultar el activo.',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
