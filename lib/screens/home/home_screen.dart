import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/monitor_overlay.dart';
import '../../widgets/sos_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Monitoreo'),
      body: Stack(
        children: [
          // Mapa (placeholder hasta integrar Mapbox)
          _MapPlaceholder(),

          // Overlay flotante superior: velocidad, batería, GPS
          const Positioned(
            top: AppConstants.paddingMD,
            left: 0,
            right: 0,
            child: Center(child: MonitorOverlay()),
          ),

          // Botón SOS inferior derecho
          Positioned(
            bottom: AppConstants.paddingXL,
            right: AppConstants.paddingLG,
            child: SosButton(
              onActivated: () => _onSosActivated(context),
            ),
          ),
        ],
      ),
    );
  }

  void _onSosActivated(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🚨 SOS activado — Enviando alerta de emergencia...'),
        backgroundColor: AppColors.sos,
        duration: Duration(seconds: 4),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFE8EDF2),
      child: Stack(
        children: [
          // Simulación visual del mapa
          CustomPaint(
            size: Size.infinite,
            painter: _MapGridPainter(),
          ),
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map, size: 64, color: AppColors.textHint),
                SizedBox(height: AppConstants.paddingSM),
                Text(
                  'Mapbox se integrará aquí',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0D8E0)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
