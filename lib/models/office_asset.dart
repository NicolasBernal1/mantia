class OfficeAsset {
  final String id;
  final String name;
  final String type;
  final String location;
  final String internalCode;

  const OfficeAsset({
    required this.id,
    required this.name,
    required this.type,
    required this.location,
    required this.internalCode,
  });

  factory OfficeAsset.fromJson(Map<String, dynamic> json) {
    return OfficeAsset(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      internalCode: json['internal_code'] as String,
    );
  }
}
