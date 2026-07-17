import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:busz/core/di/injection.dart';
import 'package:busz/core/theme/app_theme.dart';
import 'package:busz/core/router/app_router.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:busz/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('offline_cache');

  await Supabase.initialize(
    url: 'https://hgublccvksnuunppjjjw.supabase.co',
    // ignore: deprecated_member_use
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhndWJsY2N2a3NudXVucHBqamp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODMwMDgzMzgsImV4cCI6MjA5ODU4NDMzOH0.x7lodJ8KfOgluoZgu74S1gheZjENxCtxSn51YL5aX4M',
  );

  await initDependencies();

  await SentryFlutter.init(
    (options) {
      // Placeholder DSN for Sprint 3.2
      options.dsn = const String.fromEnvironment(
        'SENTRY_DSN',
        defaultValue: 'https://placeholder@sentry.io/12345',
      );
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => BookingProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BusZ - Smart Transit',
      debugShowCheckedModeBanner: false,

      // Theming
      themeMode: context.watch<ThemeProvider>().themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // Routing
      routerConfig: AppRouter.router,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
      locale: const Locale('vi', 'VN'), // Default to Vietnamese
    );
  }
}
