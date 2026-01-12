// lib/slides/slide_46.dart
import 'package:flutter/material.dart';

class Slide48 extends StatelessWidget {
  const Slide48({super.key});

  double _scaleByWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w / 1366.0).clamp(0.78, 1.22);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const imgAsset = "assets/slide48/slide48.png"; // <-- tu imagen

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              imgAsset,
              fit: BoxFit.cover,        // llena toda la pantalla
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
            ),
          ),

          // (opcional) overlay mínimo para que se vea más “pro”
          // Si no quieres NADA, borra este Container y listo.
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.04,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF2EC4FF).withValues(alpha: .35),
                        Colors.transparent,
                        const Color(0xFFFF2B2B).withValues(alpha: .30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
