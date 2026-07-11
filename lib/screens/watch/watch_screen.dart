import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../providers/watch_provider.dart';
import '../../widgets/app_bar_widget.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<WatchProvider>();

    return Scaffold(
      appBar: const AppBarWidget(title: 'Reloj'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.paddingMD),
        child: Column(
          children: [
            _WatchStatusCard(isConnected: watch.isConnected, battery: watch.battery),
            const SizedBox(height: AppConstants.paddingMD),
            _WatchFaceCard(data: watch),
            const SizedBox(height: AppConstants.paddingMD),
            _GpsToggleCard(isActive: watch.isGpsActive, onToggle: watch.toggleGps),
          ],
        ),
      ),
    );
  }
}

class _WatchStatusCard extends StatelessWidget {
  final bool isConnected;
  final int battery;

  const _WatchStatusCard({required this.isConnected, required this.battery});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.watch,
          color: isConnected ? AppColors.success : AppColors.textHint,
          size: 36,
        ),
        title: Text(isConnected ? 'Reloj conectado' : 'Sin conexión'),
        subtitle: isConnected ? Text('Batería: $battery%') : const Text('Busca tu dispositivo'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isConnected ? AppColors.success.withOpacity(0.1) : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppConstants.radiusFull),
          ),
          child: Text(
            isConnected ? 'Online' : 'Offline',
            style: TextStyle(
              color: isConnected ? AppColors.success : AppColors.textHint,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _WatchFaceCard extends StatelessWidget {
  final WatchProvider data;
  const _WatchFaceCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLG),
        child: Column(
          children: [
            const Text('Datos en tiempo real', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: AppConstants.paddingMD),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DataItem(icon: Icons.favorite, label: 'BPM', value: data.data.heartRate.toStringAsFixed(0), color: AppColors.danger),
                _DataItem(icon: Icons.speed, label: 'km/h', value: data.speed.toStringAsFixed(0), color: AppColors.primary),
                _DataItem(icon: Icons.air, label: 'SpO₂', value: '${data.data.oxygenSaturation.toStringAsFixed(0)}%', color: AppColors.info),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _DataItem({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
      ],
    );
  }
}

class _GpsToggleCard extends StatelessWidget {
  final bool isActive;
  final VoidCallback onToggle;

  const _GpsToggleCard({required this.isActive, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        secondary: Icon(
          isActive ? Icons.gps_fixed : Icons.gps_off,
          color: isActive ? AppColors.success : AppColors.textHint,
        ),
        title: const Text('GPS'),
        subtitle: Text(isActive ? 'Ubicación activa' : 'Ubicación desactivada'),
        value: isActive,
        activeColor: AppColors.success,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}
