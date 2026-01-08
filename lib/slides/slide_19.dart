// lib/slides/slide_19.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide19 extends StatefulWidget {
  const Slide19({super.key});

  @override
  State<Slide19> createState() => _Slide19State();
}

class _Slide19State extends State<Slide19> with SingleTickerProviderStateMixin {
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

    _scale = Tween<double>(begin: 0.988, end: 1.0).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.08, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.00, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    _leftIn = Tween<Offset>(begin: const Offset(-0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.12, 0.92, curve: Curves.easeOutCubic),
      ),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.14, 0.98, curve: Curves.easeOutCubic),
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
    return (w / 1366.0).clamp(0.80, 1.18);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";
    const leftBottomImage = "assets/slide19/slide19_1.jpg";
    const rightImage = "assets/slide19/slide19.jpg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28 * s, 18 * s, 28 * s, 128 * s),
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _titleIn,
                        child: _TopHeadline(
                          s: s,
                          title: "Programación IEC y NO-IEC",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ===== LEFT CARD: text + image bottom =====
                            Expanded(
                              flex: 44,
                              child: SlideTransition(
                                position: _leftIn,
                                child: _WhiteCard(
                                  s: s,
                                  radius: 30,
                                  padding: EdgeInsets.fromLTRB(
                                    18 * s,
                                    16 * s,
                                    18 * s,
                                    14 * s,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _LeftHeader(s: s),
                                      SizedBox(height: 10 * s),
                                      Expanded(
                                        child: _LeftParagraphs(s: s),
                                      ),
                                      SizedBox(height: 12 * s),

                                      // --- Bottom image inside left card ---
                                      SizedBox(
                                        height: 210 * s,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18 * s),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: _FitImageToCard(
                                                  s: s,
                                                  asset: leftBottomImage,
                                                  topInset: 8 * s,
                                                  sideInset: 8 * s,
                                                  bottomInset: 8 * s,
                                                  blurOpacity: 0.12,
                                                ),
                                              ),
                                              Positioned.fill(
                                                child: DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18 * s),
                                                    border: Border.all(
                                                      color:
                                                          const Color(0xFF59D7FF)
                                                              .withOpacity(0.55),
                                                      width: 1.6,
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
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ===== RIGHT CARD: full image =====
                            Expanded(
                              flex: 56,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _WhiteCard(
                                  s: s,
                                  radius: 34,
                                  padding: EdgeInsets.zero,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(34 * s),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: _FitImageToCard(
                                            s: s,
                                            asset: rightImage,
                                            topInset: 10 * s,
                                            sideInset: 10 * s,
                                            bottomInset: 10 * s,
                                            blurOpacity: 0.10,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(34 * s),
                                              border: Border.all(
                                                color: const Color(0xFF59D7FF)
                                                    .withOpacity(0.70),
                                                width: 2.4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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

// ===================== LEFT TEXT =====================

class _LeftHeader extends StatelessWidget {
  final double s;
  const _LeftHeader({required this.s});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Interface IDE – Entorno de Desarrollo Integrado",
      style: TextStyle(
        fontSize: 18.5 * s,
        fontWeight: FontWeight.w900,
        height: 1.1,
        color: const Color(0xFF0B1B2B).withOpacity(0.96),
      ),
    );
  }
}

class _LeftParagraphs extends StatelessWidget {
  final double s;
  const _LeftParagraphs({required this.s});

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: 15.8 * s,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF0B1B2B).withOpacity(0.90),
    );

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: RichText(
        text: TextSpan(
          style: base,
          children: [
            TextSpan(
              text: "Codificación Textual ",
              style: base.copyWith(fontWeight: FontWeight.w900),
            ),
            const TextSpan(
              text:
                  "representa un entorno de desarrollo web (editor de código, consola, depuración, etc.) con conectividad nativa con ctrlX CORE. Permite crear scripts de Python o editar archivos en la solución activa.\n\n",
            ),
            TextSpan(
              text: "Visual Coding ",
              style: base.copyWith(fontWeight: FontWeight.w900),
            ),
            const TextSpan(
              text:
                  "proporciona un marco de programación (editor de código, depurador, gestión de proyectos, configuración, etc.) para crear programas basados en elementos visuales, Python y JavaScript. El lenguaje del editor activo se puede cambiar en cualquier momento, lo que facilita el trabajo colaborativo.",
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== TITLE =====================

class _TopHeadline extends StatelessWidget {
  final double s;
  final String title;
  const _TopHeadline({required this.s, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 52 * s,
        height: 1.0,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.2,
        color: Colors.white.withOpacity(0.96),
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

// ===================== WHITE CARD =====================

class _WhiteCard extends StatelessWidget {
  final double s;
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  const _WhiteCard({
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
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.92),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.75),
              width: 2.4,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                offset: const Offset(0, 16),
                color: Colors.black.withOpacity(0.28),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// ===================== IMAGE FIT (pro) =====================

class _FitImageToCard extends StatelessWidget {
  final double s;
  final String asset;
  final double topInset;
  final double sideInset;
  final double bottomInset;
  final double blurOpacity;

  const _FitImageToCard({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
    this.blurOpacity = 0.12,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => _ImageFallback(s: s);

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
            child: Opacity(
              opacity: blurOpacity,
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => fallback(),
              ),
            ),
          ),
        ),
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.02))),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              sideInset * s,
              topInset * s,
              sideInset * s,
              bottomInset * s,
            ),
            child: Image.asset(
              asset,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) => fallback(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageFallback extends StatelessWidget {
  final double s;
  const _ImageFallback({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.06),
      child: Center(
        child: Icon(Icons.image_rounded,
            size: 54 * s, color: Colors.black.withOpacity(0.45)),
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
        Positioned.fill(child: Image.asset(asset, fit: BoxFit.cover)),
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
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.25),
                radius: 1.20,
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
