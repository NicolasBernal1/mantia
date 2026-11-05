import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/repositories/auth_repository.dart';

const bool showCrashTests = kDebugMode || bool.fromEnvironment('CRASH_TEST');

class SessionMenu extends StatelessWidget {
  final UserProfile profile;
  final AuthRepository authRepository;

  const SessionMenu({
    super.key,
    required this.profile,
    required this.authRepository,
  });

  Future<void> _onSelected(BuildContext context, String value) async {
    if (value == 'logout') {
      await authRepository.signOut();
      return;
    }

    if (value == 'test_event') {
      await FirebaseCrashlytics.instance.recordError(
        Exception('Evento de prueba controlado (no fatal)'),
        StackTrace.current,
        reason: 'Prueba manual de Crashlytics',
        fatal: false,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Evento registrado.',
          ),
        ),
      );
      return;
    }

    if (value == 'test_crash') {
      FirebaseCrashlytics.instance.crash();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => _onSelected(context, value),
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          enabled: false,
          child: Text(
            '${profile.displayName}\nRol: ${UserRole.label(profile.role)}',
          ),
        ),
        if (showCrashTests)
          const PopupMenuItem<String>(
            value: 'test_event',
            child: Text('[DEV] Evento de prueba (no fatal)'),
          ),
        if (showCrashTests)
          const PopupMenuItem<String>(
            value: 'test_crash',
            child: Text('[DEV] Forzar crash de prueba'),
          ),
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Cerrar sesión'),
        ),
      ],
    );
  }
}
