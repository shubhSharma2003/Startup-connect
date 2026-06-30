import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/routing/app_router.dart';
import 'core/config/app_theme.dart';
import 'core/constants/app_colors.dart';
import 'core/network/connectivity_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables (defaults to .env.development)
  // In a real CI/CD pipeline, you would pass a flag like --dart-define=ENV=production
  // and load the respective file based on that flag.
  await dotenv.load(fileName: ".env.development");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'StartupConnect',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Dynamically switches based on OS setting
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ConnectivityWrapper(child: child!);
      },
    );
  }
}

// Global wrapper to show an offline banner
class ConnectivityWrapper extends ConsumerWidget {
  final Widget child;
  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivity = ref.watch(connectivityProvider);
    
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          child,
          connectivity.when(
            data: (status) {
              if (status == ConnectivityResult.none) {
                return Positioned(
                  top: MediaQuery.of(context).viewPadding.top,
                  left: 0,
                  right: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      color: AppColors.error,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        'No Internet Connection',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
