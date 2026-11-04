import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mantia/auth_gate.dart';
import 'package:mantia/firebase_options.dart';
import 'package:mantia/local/app_database.dart';
import 'package:mantia/local/maintenance_order_local_data_source.dart';
import 'package:mantia/remote/maintenance_order_remote_data_source.dart';
import 'package:mantia/remote/user_remote_data_source.dart';
import 'package:mantia/repositories/asset_repository.dart';
import 'package:mantia/repositories/auth_repository.dart';
import 'package:mantia/repositories/order_repository.dart';
import 'package:mantia/services/asset_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  final database = AppDatabase();
  final firestore = FirebaseFirestore.instance;

  final orderLocal = MaintenanceOrderLocalDataSource(database);
  final orderRemote = MaintenanceOrderRemoteDataSource(firestore);
  final userRemote = UserRemoteDataSource(firestore);

  final assetService = AssetService(
    'https://dummyjson.com/c/c104-f09e-43d1-b06f',
  );

  final authRepository = AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    userRemote: userRemote,
  );
  final assetRepository = AssetRepository(
    service: assetService,
    remote: orderRemote,
  );
  final orderRepository = OrderRepository(
    local: orderLocal,
    remote: orderRemote,
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      assetRepository: assetRepository,
      orderRepository: orderRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final AssetRepository assetRepository;
  final OrderRepository orderRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.assetRepository,
    required this.orderRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mantia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: AuthGate(
        authRepository: authRepository,
        assetRepository: assetRepository,
        orderRepository: orderRepository,
      ),
    );
  }
}
