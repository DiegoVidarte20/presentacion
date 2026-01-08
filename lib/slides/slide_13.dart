// lib/slides/slide_13.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide13 extends StatefulWidget {
  const Slide13({super.key});

  @override
  State<Slide13> createState() => _Slide13State();
}

class _Slide13State extends State<Slide13> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rightIn;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _scale = Tween<double>(begin: 0.985, end: 1.0).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.10, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
      ),
    );

    _leftIn = Tween<Offset>(begin: const Offset(-0.10, 0), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.10, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.10, 0), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.14, 0.92, curve: Curves.easeOutCubic),
      ),
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
    return (w / 1366.0).clamp(0.80, 1.20);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    // ===== Cambia assets aquí =====
    const bgAsset = "assets/slide1/fondoslide1.jpeg";
    const imgLeftTop = "assets/slide13/slide13_1.jpeg";   // imagen grande 1
    const imgRightBig = "assets/slide13/slide13_2.jpeg";  // imagen grande 2

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28 * s, 22 * s, 28 * s, 128 * s),
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _titleIn,
                        child: _TopHeadline(s: s, title: "Built in Security"),
                      ),
                      SizedBox(height: 18 * s),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ================= LEFT: IMAGEN GRANDE 1 + PILLS ABAJO =================
                            Expanded(
                              flex: 44,
                              child: SlideTransition(
                                position: _leftIn,
                                child: Column(
                                  children: [
                                    // ---- imagen grande izquierda (arriba) ----
                                    Expanded(
                                      flex: 58,
                                      child: _GlassCard(
                                        s: s,
                                        radius: 28,
                                        padding: EdgeInsets.zero,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(28 * s),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Image.asset(
                                                  imgLeftTop,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                  errorBuilder: (_, __, ___) =>
                                                      _ImageFallback(
                                                    s: s,
                                                    label:
                                                        "IMAGEN GRANDE 1\n(placeholder)",
                                                  ),
                                                ),
                                              ),
                                              // borde suave adentro
                                              Positioned.fill(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28 * s),
                                                    border: Border.all(
                                                      color: const Color(
                                                              0xFF59D7FF)
                                                          .withOpacity(0.45),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 16 * s),

                                    // ---- pills inferiores (base) ----
                                    Expanded(
                                      flex: 42,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: _SmallPill(
                                                    s: s,
                                                    text:
                                                        "1.- Defensa en\nProfundidad",
                                                    strong: true,
                                                  ),
                                                ),
                                                SizedBox(width: 14 * s),
                                                Expanded(
                                                  child: _SmallPill(
                                                    s: s,
                                                    text:
                                                        "Capa 2:\nAislamiento\n(Sandbox)",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 14 * s),
                                          Expanded(
                                            child: _SmallPill(
                                              s: s,
                                              text:
                                                  "Capa 1: Hardware y\nSistema Operativo Base",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ================= RIGHT: PILLS ARRIBA + IMAGEN GRANDE 2 =================
                            Expanded(
                              flex: 56,
                              child: SlideTransition(
                                position: _rightIn,
                                child: Column(
                                  children: [
                                    // ---- pills superiores (wrap) ----
                                    _TopPillsRow(s: s),

                                    SizedBox(height: 16 * s),

                                    // ---- imagen grande derecha (abajo) ----
                                    Expanded(
                                      child: _GlassCard(
                                        s: s,
                                        radius: 30,
                                        padding: EdgeInsets.zero,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30 * s),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Image.asset(
                                                  imgRightBig,
                                                  fit: BoxFit.contain,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  errorBuilder: (_, __, ___) =>
                                                      _ImageFallback(
                                                    s: s,
                                                    label:
                                                        "IMAGEN GRANDE 2\n(placeholder)",
                                                  ),
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30 * s),
                                                    border: Border.all(
                                                      color: const Color(
                                                              0xFF59D7FF)
                                                          .withOpacity(0.45),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ===== Footer reusable =====
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

// ===================== TOP HEADLINE =====================

class _TopHeadline extends StatelessWidget {
  final double s;
  final String title;

  const _TopHeadline({required this.s, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 54 * s,
        height: 1.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.2,
        color: Colors.white.withOpacity(0.95),
        shadows: [
          Shadow(
            blurRadius: 22,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.45),
          ),
        ],
      ),
    );
  }
}

// ===================== TOP PILLS (RIGHT) =====================

class _TopPillsRow extends StatelessWidget {
  final double s;
  const _TopPillsRow({required this.s});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SmallPill(s: s, text: "Capa 3:\nSeguridad de Red\n& Comunicaciones")),
        SizedBox(width: 12 * s),
        Expanded(child: _SmallPill(s: s, text: "Capa 4:\nGestión de Usuarios\n(RBAC)")),
        SizedBox(width: 12 * s),
        Expanded(child: _SmallPill(s: s, text: "2.- Secure by\nDesign", strong: true)),
        SizedBox(width: 12 * s),
        Expanded(child: _SmallPill(s: s, text: "3.- IEC 62443\nSL3", strong: true)),
      ],
    );
  }
}

// ===================== SMALL PILL =====================

class _SmallPill extends StatelessWidget {
  final double s;
  final String text;
  final bool strong;

  const _SmallPill({
    required this.s,
    required this.text,
    this.strong = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = 24 * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 12 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.85),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, 10),
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.5 * s,
                height: 1.15,
                fontWeight: strong ? FontWeight.w900 : FontWeight.w700,
                color: Colors.black.withOpacity(0.88),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== GLASS CARD =====================

class _GlassCard extends StatelessWidget {
  final double s;
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  const _GlassCard({
    required this.s,
    required this.child,
    this.radius = 26,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.35),
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                offset: const Offset(0, 16),
                color: Colors.black.withOpacity(0.32),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.10),
                        Colors.transparent,
                        Colors.black.withOpacity(0.08),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== FALLBACK IMAGE =====================

class _ImageFallback extends StatelessWidget {
  final double s;
  final String label;
  const _ImageFallback({required this.s, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_rounded,
              size: 56 * s,
              color: Colors.white.withOpacity(0.70),
            ),
            SizedBox(height: 10 * s),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5 * s,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.78),
              ),
            ),
          ],
        ),
      ),
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
        Positioned.fill(
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.20),
                  Colors.black.withOpacity(0.60),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.2),
                radius: 1.2,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.45),
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
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.step != step;
}
