class OrderStatus {
  OrderStatus._();

  static const requested = 'SOLICITADA';
  static const authorized = 'AUTORIZADA';
  static const diagnosed = 'DIAGNOSTICADA';
  static const inRepair = 'EN_REPARACION';
  static const finished = 'TERMINADA';
  static const closed = 'CERRADA';
  static const rejected = 'RECHAZADA';

  static String label(String status) {
    switch (status) {
      case requested:
        return 'Solicitada';
      case authorized:
        return 'Autorizada';
      case diagnosed:
        return 'Diagnosticada';
      case inRepair:
        return 'En reparación';
      case finished:
        return 'Terminada';
      case closed:
        return 'Cerrada';
      case rejected:
        return 'Rechazada';
      default:
        return status;
    }
  }
}

class OrderPriority {
  OrderPriority._();

  static const low = 'BAJA';
  static const medium = 'MEDIA';
  static const high = 'ALTA';

  static const all = [low, medium, high];

  static String label(String priority) {
    switch (priority) {
      case low:
        return 'Baja';
      case medium:
        return 'Media';
      case high:
        return 'Alta';
      default:
        return priority;
    }
  }
}
