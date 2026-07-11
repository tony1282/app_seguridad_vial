import 'package:flutter/material.dart';
import '../screens/activity/activity_screen.dart';
import '../screens/watch/watch_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/notifications/notifications_screen.dart';
import '../widgets/main_scaffold.dart';
import 'app_constants.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> get routes => {
        AppConstants.routeHome: (_) => const MainScaffold(),
        AppConstants.routeActivity: (_) => const ActivityScreen(),
        AppConstants.routeWatch: (_) => const WatchScreen(),
        AppConstants.routeSettings: (_) => const SettingsScreen(),
        AppConstants.routeNotifications: (_) => const NotificationsScreen(),
      };
}
