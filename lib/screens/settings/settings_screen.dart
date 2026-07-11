import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../widgets/app_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Configuración'),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.paddingMD),
        children: [
          _SectionHeader(title: 'Dispositivo'),
          _SettingsTile(icon: Icons.watch, title: 'Smartwatch', subtitle: 'Gestionar conexión Bluetooth'),
          _SettingsTile(icon: Icons.gps_fixed, title: 'GPS', subtitle: 'Configurar precisión de ubicación'),
          const SizedBox(height: AppConstants.paddingMD),
          _SectionHeader(title: 'Alertas'),
          _SettingsTile(icon: Icons.speed, title: 'Límite de velocidad', subtitle: 'Alerta a 80 km/h'),
          _SettingsTile(icon: Icons.battery_alert, title: 'Batería baja', subtitle: 'Alerta al 20%'),
          _SettingsTile(icon: Icons.sos, title: 'Contactos SOS', subtitle: 'Gestionar contactos de emergencia'),
          const SizedBox(height: AppConstants.paddingMD),
          _SectionHeader(title: 'App'),
          _SettingsTile(icon: Icons.notifications, title: 'Notificaciones', subtitle: 'Gestionar alertas'),
          _SettingsTile(icon: Icons.info_outline, title: 'Acerca de', subtitle: 'Versión 1.0.0'),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.paddingSM),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.paddingSM),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textHint),
        onTap: () {},
      ),
    );
  }
}
