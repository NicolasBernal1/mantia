import 'dart:math';

String newOrderId() {
  final random = Random.secure();
  final randomPart = List.generate(6, (_) => random.nextInt(36).toRadixString(36)).join();
  final timePart = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
  return 'ord_$timePart$randomPart';
}
