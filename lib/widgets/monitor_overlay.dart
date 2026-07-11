import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../providers/watch_provider.dart';

class MonitorOverlay extends StatelessWidget {
  const MonitorOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<WatchProvider>();

    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMD),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMD,
        vertical: AppConstants.paddingSM,
      ),
      decoration: BoxDecoration(
        color: AppColors.mapOverlay,
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
        boxShadow: const [
          BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SpeedIndicator(speed: watch.speed),
          const _Divider(),
          _BatteryIndicator(battery: watch.battery),
          const _Divider(),
          _GpsIndicator(isActive: watch.isGpsActive),
        ],
      ),
    );
  }
}

class _SpeedIndicator extends StatelessWidget {
  final double speed;
  const _SpeedIndicator({required this.speed});

  Color get _color {
    if (speed >= AppConstants.speedDangerThreshold) return AppColors.speedDanger;
    if (speed >= AppConstants.speedWarningThreshold) return AppColors.speedWarning;
    return AppColors.speedNormal;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          speed.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _color,
          ),
        ),
        const Text('km/h', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _BatteryIndicator extends StatelessWidget {
  final int battery;
  const _BatteryIndicator({required this.battery});

  Color get _color {
    if (battery <= AppConstants.batteryDangerThreshold) return AppColors.danger;
    if (battery <= AppConstants.batteryWarningThreshold) return AppColors.warning;
    return AppColors.success;
  }

  IconData get _icon {
    if (battery <= 20) return Icons.battery_alert;
    if (battery <= 50) return Icons.battery_3_bar;
    return Icons.battery_full;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(_icon, color: _color, size: 20),
        Text(
          '$battery%',
          style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _GpsIndicator extends StatelessWidget {
  final bool isActive;
  const _GpsIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isActive ? Icons.gps_fixed : Icons.gps_off,
          color: isActive ? AppColors.success : AppColors.textHint,
          size: 20,
        ),
        Text(
          isActive ? 'GPS' : 'Off',
          style: TextStyle(
            fontSize: 10,
            color: isActive ? AppColors.success : AppColors.textHint,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingSM),
      color: AppColors.surfaceVariant,
    );
  }
}
