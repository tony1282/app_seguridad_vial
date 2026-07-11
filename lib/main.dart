import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'config/app_routes.dart';
import 'config/app_constants.dart';
import 'providers/watch_provider.dart';
import 'providers/notification_provider.dart';
import 'widgets/main_scaffold.dart';

void main() {
  runApp(const AppSeguridadVial());
}

class AppSeguridadVial extends StatelessWidget {
  const AppSeguridadVial({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Seguridad Vial',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: AppRoutes.routes,
      ),
    );
  }
}
