import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message){
    if(kDebugMode) debugPrint('[DEBUG] $message');
  }

  static void warning(String message){
    debugPrint('[WARNING] $message');
  }

  static void error(String message, Object? error, StackTrace? stackTrace){
    debugPrint('[ERROR] $message');
    if(error != null) debugPrint(error.toString());
    if(stackTrace != null) debugPrint(stackTrace.toString());
  }

  static void unexpected(String message, Object error, StackTrace stackTrace){
    AppLogger.error(message, error, stackTrace);
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: message,
      fatal: false,
    );
  }
}
