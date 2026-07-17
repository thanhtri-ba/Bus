/// BusZ — Dependency Injection Setup
///
/// Source of Truth: BusZ-Documentation/06_Flutter/01_App_Architecture.md §13
///
/// Uses `get_it` for Service Locator pattern.
library;

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:busz/services/address_service.dart';
import 'package:busz/services/payment_method_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ─── External ───────────────────────────────────────────────────
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() {
    final dio = Dio(
      BaseOptions(
        baseUrl:
            'https://api.busz.com/v1', // Placeholder for NestJS backend later
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Generate correlation ID
          final correlationId = const Uuid().v4();
          options.headers['x-correlation-id'] = correlationId;

          // Attach to Sentry scope
          Sentry.configureScope((scope) {
            scope.setTag('correlation_id', correlationId);
          });

          return handler.next(options);
        },
      ),
    );
    return dio;
  });

  // ─── Core ───────────────────────────────────────────────────────
  sl.registerLazySingleton(() => AddressService());
  sl.registerLazySingleton(() => PaymentMethodService());

  // ─── Repositories ───────────────────────────────────────────────

  // ─── Use Cases ──────────────────────────────────────────────────

  // ─── Blocs / Cubits ─────────────────────────────────────────────
}
