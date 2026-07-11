class AppConstants {
  // Velocidades límite (km/h)
  static const double speedWarningThreshold = 80.0;
  static const double speedDangerThreshold = 100.0;

  // Batería
  static const int batteryWarningThreshold = 20;
  static const int batteryDangerThreshold = 10;

  // Padding / Spacing
  static const double paddingXS = 4.0;
  static const double paddingSM = 8.0;
  static const double paddingMD = 16.0;
  static const double paddingLG = 24.0;
  static const double paddingXL = 32.0;

  // Border radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusFull = 100.0;

  // Nombres de rutas
  static const String routeHome = '/';
  static const String routeActivity = '/activity';
  static const String routeWatch = '/watch';
  static const String routeSettings = '/settings';
  static const String routeNotifications = '/notifications';
}
