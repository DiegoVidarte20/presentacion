import 'package:flutter/material.dart';

class SlideShell extends StatelessWidget {
  final int index; // 1-based
  final int total;
  final Widget child;

  const SlideShell({
    super.key,
    required this.index,
    required this.total,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: child),

            // Footer simple (puedes quitarlo si no lo quieres)
            Positioned(
              left: 18,
              bottom: 12,
              child: Text(
                '$index/$total',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
