class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}

enum NotificationType { sos, speed, battery, gps, info }
