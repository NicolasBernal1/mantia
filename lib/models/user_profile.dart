class UserRole {
  UserRole._();

  static const requester = 'solicitante';
  static const supervisor = 'supervisor';
  static const technician = 'tecnico';

  static String label(String role) {
    switch (role) {
      case supervisor:
        return 'Supervisor';
      case technician:
        return 'Técnico';
      default:
        return 'Solicitante';
    }
  }
}

class UserProfile {
  final String uid;
  final String email;
  final String displayName;
  final String role;

  const UserProfile({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'display_name': displayName,
    'role': role,
    'created_at': DateTime.now().toIso8601String(),
  };
}
