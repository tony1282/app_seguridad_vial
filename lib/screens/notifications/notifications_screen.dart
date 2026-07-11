import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../models/notification_model.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/app_bar_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      appBar: AppBarWidget(
        title: 'Notificaciones',
        extraActions: [
          if (provider.unreadCount > 0)
            TextButton(
              onPressed: provider.markAllAsRead,
              child: const Text('Leer todo', style: TextStyle(color: AppColors.primary)),
            ),
        ],
      ),
      body: provider.notifications.isEmpty
          ? const _EmptyNotifications()
          : ListView.builder(
              padding: const EdgeInsets.all(AppConstants.paddingMD),
              itemCount: provider.notifications.length,
              itemBuilder: (_, i) => _NotificationTile(
                notification: provider.notifications[i],
                onTap: () => provider.markAsRead(provider.notifications[i].id),
              ),
            ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _NotificationTile({required this.notification, required this.onTap});

  Color get _typeColor {
    switch (notification.type) {
      case NotificationType.sos: return AppColors.sos;
      case NotificationType.speed: return AppColors.warning;
      case NotificationType.battery: return AppColors.danger;
      case NotificationType.gps: return AppColors.info;
      case NotificationType.info: return AppColors.primary;
    }
  }

  IconData get _typeIcon {
    switch (notification.type) {
      case NotificationType.sos: return Icons.sos;
      case NotificationType.speed: return Icons.speed;
      case NotificationType.battery: return Icons.battery_alert;
      case NotificationType.gps: return Icons.gps_fixed;
      case NotificationType.info: return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSM),
      color: notification.isRead ? AppColors.surface : AppColors.primaryLight,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _typeColor.withOpacity(0.15),
          child: Icon(_typeIcon, color: _typeColor, size: 20),
        ),
        title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(notification.body),
        trailing: notification.isRead
            ? null
            : Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
              ),
        onTap: onTap,
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.notifications_none, size: 64, color: AppColors.textHint),
          SizedBox(height: AppConstants.paddingMD),
          Text('Sin notificaciones', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
        ],
      ),
    );
  }
}
