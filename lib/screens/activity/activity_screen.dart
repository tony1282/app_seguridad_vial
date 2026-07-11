import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../providers/watch_provider.dart';
import '../../widgets/app_bar_widget.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<WatchProvider>();

    return Scaffold(
      appBar: const AppBarWidget(title: 'Actividad'),
      body: watch.isConnected
          ? _ActivityContent(data: watch)
          : const _WatchDisconnected(),
    );
  }
}

class _ActivityContent extends StatelessWidget {
  final WatchProvider data;
  const _ActivityContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMD),
      child: Column(
        children: [
          // Tarjeta principal: ritmo cardíaco
          _HeartRateCard(heartRate: data.data.heartRate),
          const SizedBox(height: AppConstants.paddingMD),

          // Grid de métricas
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppConstants.paddingMD,
            mainAxisSpacing: AppConstants.paddingMD,
            childAspectRatio: 1.2,
            children: [
              _MetricCard(
                icon: Icons.directions_walk,
                label: 'Pasos',
                value: data.data.steps.toStringAsFixed(0),
                unit: 'pasos',
                color: AppColors.primary,
              ),
              _MetricCard(
                icon: Icons.local_fire_department,
                label: 'Calorías',
                value: data.data.calories.toStringAsFixed(0),
                unit: 'kcal',
                color: AppColors.warning,
              ),
              _MetricCard(
                icon: Icons.straighten,
                label: 'Distancia',
                value: data.data.distance.toStringAsFixed(2),
                unit: 'km',
                color: AppColors.success,
              ),
              _MetricCard(
                icon: Icons.air,
                label: 'SpO₂',
                value: data.data.oxygenSaturation.toStringAsFixed(0),
                unit: '%',
                color: AppColors.info,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingMD),

          // Estado GPS y velocidad
          _StatusRow(
            speed: data.speed,
            isGpsActive: data.isGpsActive,
            battery: data.battery,
          ),
        ],
      ),
    );
  }
}

class _HeartRateCard extends StatelessWidget {
  final double heartRate;
  const _HeartRateCard({required this.heartRate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingLG),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: AppColors.danger, size: 48),
            const SizedBox(width: AppConstants.paddingMD),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ritmo Cardíaco', style: TextStyle(color: AppColors.textSecondary)),
                Text(
                  '${heartRate.toStringAsFixed(0)} bpm',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMD),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: AppConstants.paddingXS),
            Text(
              value,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
            ),
            Text(unit, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final double speed;
  final bool isGpsActive;
  final int battery;

  const _StatusRow({
    required this.speed,
    required this.isGpsActive,
    required this.battery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.paddingMD),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StatusItem(
              icon: Icons.speed,
              label: '${speed.toStringAsFixed(0)} km/h',
              sublabel: 'Velocidad',
              color: AppColors.primary,
            ),
            _StatusItem(
              icon: isGpsActive ? Icons.gps_fixed : Icons.gps_off,
              label: isGpsActive ? 'Activo' : 'Inactivo',
              sublabel: 'GPS',
              color: isGpsActive ? AppColors.success : AppColors.textHint,
            ),
            _StatusItem(
              icon: Icons.battery_full,
              label: '$battery%',
              sublabel: 'Batería',
              color: battery <= 20 ? AppColors.danger : AppColors.success,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;

  const _StatusItem({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        Text(sublabel, style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
      ],
    );
  }
}

class _WatchDisconnected extends StatelessWidget {
  const _WatchDisconnected();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.watch_off, size: 64, color: AppColors.textHint),
          SizedBox(height: AppConstants.paddingMD),
          Text('Smartwatch no conectado', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          SizedBox(height: AppConstants.paddingSM),
          Text('Conecta tu reloj para ver la actividad', style: TextStyle(color: AppColors.textHint)),
        ],
      ),
    );
  }
}
