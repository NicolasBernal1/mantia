import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mantia/asset_screen.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/login_screen.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/order_screen.dart';
import 'package:mantia/repositories/asset_repository.dart';
import 'package:mantia/repositories/auth_repository.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/widgets/error_view.dart';
import 'package:mantia/widgets/loading_view.dart';

class AuthGate extends StatelessWidget {
  final AuthRepository authRepository;
  final AssetRepository assetRepository;
  final OrderRepository orderRepository;

  const AuthGate({
    super.key,
    required this.authRepository,
    required this.assetRepository,
    required this.orderRepository,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authRepository.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: LoadingView());
        }

        final user = snapshot.data;
        if (user == null) {
          return LoginScreen(authRepository: authRepository);
        }

        return _ProfileGate(
          key: ValueKey(user.uid),
          user: user,
          authRepository: authRepository,
          assetRepository: assetRepository,
          orderRepository: orderRepository,
        );
      },
    );
  }
}

class _ProfileGate extends StatefulWidget {
  final User user;
  final AuthRepository authRepository;
  final AssetRepository assetRepository;
  final OrderRepository orderRepository;

  const _ProfileGate({
    super.key,
    required this.user,
    required this.authRepository,
    required this.assetRepository,
    required this.orderRepository,
  });

  @override
  State<_ProfileGate> createState() => _ProfileGateState();
}

class _ProfileGateState extends State<_ProfileGate> {
  late Future<UserProfile> _futureProfile;

  @override
  void initState() {
    super.initState();
    _futureProfile = widget.authRepository.getProfile(widget.user);
  }

  void retryProfile() {
    setState(() {
      _futureProfile = widget.authRepository.getProfile(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile>(
      future: _futureProfile,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: LoadingView());
        }

        if (snapshot.hasError) {
          final error = snapshot.error;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mantia'),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: widget.authRepository.signOut,
                  child: const Text('Salir'),
                ),
              ],
            ),
            body: ErrorView(
              message: error is AppException
                  ? error.message
                  : 'No pudimos cargar tu perfil',
              onRetry: retryProfile,
            ),
          );
        }

        final profile = snapshot.data!;

        if (profile.role == UserRole.requester) {
          return AssetScreen(
            profile: profile,
            authRepository: widget.authRepository,
            assetRepository: widget.assetRepository,
            orderRepository: widget.orderRepository,
          );
        }

        return OrderScreen(
          profile: profile,
          authRepository: widget.authRepository,
          assetRepository: widget.assetRepository,
          orderRepository: widget.orderRepository,
        );
      },
    );
  }
}
