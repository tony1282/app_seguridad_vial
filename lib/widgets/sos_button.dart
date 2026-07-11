import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';

class SosButton extends StatefulWidget {
  final VoidCallback onActivated;
  const SosButton({super.key, required this.onActivated});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirmSos(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusLG)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.sos),
            SizedBox(width: 8),
            Text('Activar SOS'),
          ],
        ),
        content: const Text('¿Confirmas que necesitas ayuda de emergencia?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.sos),
            onPressed: () {
              Navigator.pop(context);
              widget.onActivated();
            },
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulse,
      child: GestureDetector(
        onTap: () => _confirmSos(context),
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.sos,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.sos.withOpacity(0.4),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sos, color: Colors.white, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
