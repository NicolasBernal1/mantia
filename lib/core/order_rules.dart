import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/order_status.dart';

class OrderRules {
  OrderRules._();

  static const int repairBudget = 300000;

  static String? validateDescription(String text) {
    final cleanText = text.trim();
    if (cleanText.length < 10) {
      return 'Describe la falla (minimo 10 caracteres).';
    }
    if (cleanText.length > 500) {
      return 'La descripcion no puede superar 500 caracteres.';
    }
    return null;
  }

  static String? validateDiagnosis(String cause, int? cost) {
    if (cause.trim().length < 5) {
      return 'Indica la causa de la falla (minimo 5 caracteres).';
    }
    if (cost == null) return 'Ingresa un costo estimado valido (solo numeros).';
    if (cost < 0) return 'El costo estimado no puede ser negativo.';
    return null;
  }

  static String? checkCanStartRepair(MaintenanceOrder order) {
    if (order.status != OrderStatus.diagnosed) {
      return 'Primero se debe registrar el diagnostico de la orden.';
    }
    if (!order.hasCompleteDiagnosis) {
      return 'No se puede iniciar sin un diagnostico completo (causa y costo).';
    }
    if (order.isOverBudget) {
      return 'El costo estimado supera el presupuesto permitido. '
          'Supervision debe rechazar la orden.';
    }
    return null;
  }

  static String? validateCloseResult(String text) {
    if (text.trim().length < 5) {
      return 'Registra el resultado de tu verificacion (minimo 5 caracteres).';
    }
    return null;
  }

  static String? validateRejectionReason(String text) {
    if (text.trim().length < 5) {
      return 'Indica el motivo del rechazo (minimo 5 caracteres).';
    }
    return null;
  }

  static int? parseCost(String text) {
    final cleanText = text.trim().replaceAll('.', '').replaceAll(',', '');
    return int.tryParse(cleanText);
  }

  static String formatMoney(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return '\$$buffer';
  }
}
