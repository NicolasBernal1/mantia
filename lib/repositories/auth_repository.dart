import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/remote/user_remote_data_source.dart';

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final UserRemoteDataSource userRemote;

  String? _nameForNewProfile;

  AuthRepository({required this.firebaseAuth, required this.userRemote});

  Stream<User?> authStateChanges() => firebaseAuth.authStateChanges();

  Future<void> signIn(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw AppException(_authMessage(error));
    }
  }

  Future<void> register(String name, String email, String password) async {
    _nameForNewProfile = name.trim();
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      _nameForNewProfile = null;
      throw AppException(_authMessage(error));
    }
  }

  Future<void> signOut() => firebaseAuth.signOut();

  Future<UserProfile> getProfile(User user) async {
    try {
      final existing = await userRemote.getProfile(user.uid);
      if (existing != null) return existing;

      final email = user.email ?? '';
      final name = _nameForNewProfile ?? email.split('@').first;
      final created = await userRemote.createProfile(
        uid: user.uid,
        email: email,
        displayName: name,
      );
      _nameForNewProfile = null;
      return created;
    } on FirebaseException catch (error) {
      if (error.code == 'unavailable') {
        throw const AppException('Sin conexión. No se pudo cargar tu perfil.');
      }
      throw const AppException(
        'No se pudo cargar tu perfil. Inténtalo de nuevo.',
      );
    }
  }

  Future<List<UserProfile>> getTechnicians() async {
    try {
      return await userRemote.getTechnicians();
    } on FirebaseException {
      throw const AppException('No se pudo cargar la lista de técnicos.');
    }
  }

  String _authMessage(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'El correo no tiene un formato válido.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'email-already-in-use':
        return 'Ya existe una cuenta con ese correo.';
      case 'weak-password':
        return 'La contraseña es muy débil. Usa al menos 6 caracteres.';
      case 'network-request-failed':
        return 'Sin conexión. Revisa tu Internet e inténtalo de nuevo.';
      default:
        return 'No se pudo completar la autenticación. Inténtalo de nuevo.';
    }
  }
}
