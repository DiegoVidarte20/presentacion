// lib/slides/slide_42.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide42 extends StatefulWidget {
  const Slide42({super.key});

  @override
  State<Slide42> createState() => _Slide42State();
}

class _Slide42State extends State<Slide42> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _in;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _scale = Tween<double>(begin: 0.985, end: 1.0).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.08, 1.0, curve: Curves.easeOutBack)),
    );

    _in = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.05, 0.95, curve: Curves.easeOutCubic)),
    );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _scaleByWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w / 1366.0).clamp(0.78, 1.22);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          // overlay suave para que el card reviente
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.12),
                    Colors.black.withOpacity(0.42),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28 * s, 22 * s, 28 * s, 128 * s),
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: SlideTransition(
                    position: _in,
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1120 * s),
                        child: _HeroTitleCard(scale: s),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _fade,
              child: FooterBand(scale: s),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== HERO TITLE (OPEN & EXTENDABLE) =====================

class _HeroTitleCard extends StatelessWidget {
  final double scale;
  const _HeroTitleCard({required this.scale});

  @override
  Widget build(BuildContext context) {
    final s = scale;

    final big = 106.0 * s; // OPEN &
    final mid = 66.0 * s;  // EXTENDABLE

    return ClipRRect(
      borderRadius: BorderRadius.circular(36 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(34 * s, 30 * s, 34 * s, 30 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(36 * s),
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 42 * s,
                offset: Offset(0, 20 * s),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // barrita azul -> rojo arriba (igualito al ejemplo)
              Container(
                height: 8 * s,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF2EC4FF).withOpacity(0.95),
                      Colors.white.withOpacity(0.12),
                      const Color(0xFFFF2B2B).withOpacity(0.90),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22 * s),

              // OPEN &
              FittedBox(
                fit: BoxFit.scaleDown,
                child: _OutlinedText(
                  "OPEN &",
                  fontSize: big,
                  weight: FontWeight.w900,
                  letterSpacing: 1.6 * s,
                  fillColor: Colors.white.withOpacity(0.94),
                  strokeColor: Colors.black.withOpacity(0.35),
                  strokeWidth: 6.0 * s,
                  shadow: true,
                ),
              ),

              SizedBox(height: 10 * s),

              // EXTENDABLE
              FittedBox(
                fit: BoxFit.scaleDown,
                child: _OutlinedText(
                  "EXTENDABLE",
                  fontSize: mid,
                  weight: FontWeight.w900,
                  letterSpacing: 1.9 * s,
                  fillColor: Colors.white.withOpacity(0.90),
                  strokeColor: Colors.black.withOpacity(0.30),
                  strokeWidth: 5.2 * s,
                  shadow: true,
                ),
              ),

              SizedBox(height: 14 * s),

              // tagline chiquito (puedes cambiarlo o borrarlo si no quieres)
              Opacity(
                opacity: 0.84,
                child: Text(
                  "Open ecosystem. Ready to extend.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18 * s,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.35,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Texto con stroke + fill (sin paquetes)
class _OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight weight;
  final double letterSpacing;
  final Color fillColor;
  final Color strokeColor;
  final double strokeWidth;
  final bool shadow;

  const _OutlinedText(
    this.text, {
    required this.fontSize,
    required this.weight,
    required this.letterSpacing,
    required this.fillColor,
    required this.strokeColor,
    required this.strokeWidth,
    this.shadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: fontSize,
      fontWeight: weight,
      letterSpacing: letterSpacing,
      height: 0.98,
    );

    return Stack(
      children: [
        Text(
          text,
          style: base.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ),
        ),
        Text(
          text,
          style: base.copyWith(
            color: fillColor,
            shadows: shadow
                ? [
                    Shadow(
                      blurRadius: 30,
                      offset: const Offset(0, 14),
                      color: Colors.black.withOpacity(0.45),
                    ),
                  ]
                : null,
          ),
        ),
      ],
    );
  }
}

// ===================== BACKGROUND =====================

class _BackgroundImage extends StatelessWidget {
  final String asset;
  final double s;
  const _BackgroundImage({required this.asset, required this.s});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(asset, fit: BoxFit.cover)),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF2EC4FF).withOpacity(0.14),
                  Colors.black.withOpacity(0.28),
                  const Color(0xFFFF2B2B).withOpacity(0.12),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.18),
                  Colors.black.withOpacity(0.62),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.06,
              child: CustomPaint(painter: _GridPainter(step: 42 * s)),
            ),
          ),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  final double step;
  _GridPainter({required this.step});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;
    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.step != step;
}
