import 'package:flutter/material.dart';

class SlideShell extends StatelessWidget {
  final int index; // 1-based
  final int total;
  final Widget child;

  /// Ajusta esto si quieres moverlo fino.
  final EdgeInsets counterPadding;

  const SlideShell({
    super.key,
    required this.index,
    required this.total,
    required this.child,
    this.counterPadding = const EdgeInsets.only(left: 26, bottom: 18),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: child),

          // ✅ SOLO IZQUIERDA: contador
          Positioned(
            left: counterPadding.left,
            bottom: counterPadding.bottom,
            child: Text(
              '$index/$total',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
