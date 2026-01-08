// lib/slides/slide_17.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide17 extends StatefulWidget {
  const Slide17({super.key});

  @override
  State<Slide17> createState() => _Slide17State();
}

class _Slide17State extends State<Slide17> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftTopIn;
  late final Animation<Offset> _leftBottomIn;
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

    _leftTopIn = Tween<Offset>(begin: const Offset(-0.05, 0.03), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.10, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _leftBottomIn =
        Tween<Offset>(begin: const Offset(-0.05, 0.05), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.16, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.12, 0.95, curve: Curves.easeOutCubic),
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
    const rightImage = "assets/slide17/slide17.jpg"; // 👈 tu imagen grande derecha

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
                            // ===== LEFT (2 cards) =====
                            Expanded(
                              flex: 38,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: SlideTransition(
                                      position: _leftTopIn,
                                      child: _WhiteCard(
                                        s: s,
                                        radius: 28,
                                        padding: EdgeInsets.fromLTRB(
                                          18 * s,
                                          16 * s,
                                          18 * s,
                                          14 * s,
                                        ),
                                        child: _InfoBlock(
                                          s: s,
                                          title:
                                              "ctrlX con IEC (Programación\nTradicional)",
                                          body:
                                              "Utiliza la aplicación ctrlX PLC, que integra\nun entorno basado en CODESYS.",
                                          bullets: const [
                                            "Lenguajes: Soporta los cinco lenguajes\ndel estándar IEC 61131-3 (LD, ST, FBD,\nSFC e IL).",
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16 * s),
                                  Expanded(
                                    child: SlideTransition(
                                      position: _leftBottomIn,
                                      child: _WhiteCard(
                                        s: s,
                                        radius: 28,
                                        padding: EdgeInsets.fromLTRB(
                                          18 * s,
                                          16 * s,
                                          18 * s,
                                          14 * s,
                                        ),
                                        child: _InfoBlock(
                                          s: s,
                                          title:
                                              "ctrlX sin IEC (Programación\nModerna / IT)",
                                          body:
                                              "Aprovecha que el sistema operativo ctrlX\nOS está basado en Linux (Ubuntu Core)\nen tiempo real, permitiendo prescindir de\nla estructura clásica de PLC.",
                                          bullets: const [
                                            "Lenguajes: Los desarrolladores pueden\nusar lenguajes de alto nivel como Python,\nC++, C#, Java o Node-RED.",
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ===== RIGHT (big image) =====
                            Expanded(
                              flex: 62,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _WhiteCard(
                                  s: s,
                                  radius: 32,
                                  padding: EdgeInsets.zero,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32 * s),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: _FitImageToCard(
                                            s: s,
                                            asset: rightImage,
                                            topInset: 10 * s,
                                            sideInset: 10 * s,
                                            bottomInset: 10 * s,
                                          ),
                                        ),
                                        // borde azul pro
                                        Positioned.fill(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(32 * s),
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

// ===================== LEFT TEXT BLOCK =====================

class _InfoBlock extends StatelessWidget {
  final double s;
  final String title;
  final String body;
  final List<String> bullets;

  const _InfoBlock({
    required this.s,
    required this.title,
    required this.body,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22 * s,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B1B2B).withOpacity(0.96),
              height: 1.10,
            ),
          ),
        ),
        SizedBox(height: 14 * s),
        Text(
          body,
          style: TextStyle(
            fontSize: 17.5 * s,
            height: 1.25,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1B2B).withOpacity(0.90),
          ),
        ),
        SizedBox(height: 10 * s),
        ...bullets.map((t) => _BulletLineDark(s: s, text: t)),
      ],
    );
  }
}

class _BulletLineDark extends StatelessWidget {
  final double s;
  final String text;
  const _BulletLineDark({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 7 * s),
            child: Container(
              width: 6.5 * s,
              height: 6.5 * s,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0B1B2B).withOpacity(0.82),
              ),
            ),
          ),
          SizedBox(width: 10 * s),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17 * s,
                height: 1.22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0B1B2B).withOpacity(0.90),
              ),
            ),
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
            color: Colors.white.withOpacity(0.90),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.70),
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

  const _FitImageToCard({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => _ImageFallback(s: s, label: "IMAGEN\n(placeholder)");

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => fallback(),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(0.04)),
        ),
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
  final String label;
  const _ImageFallback({required this.s, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.06),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_rounded,
                size: 56 * s, color: Colors.black.withOpacity(0.55)),
            SizedBox(height: 10 * s),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5 * s,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w900,
                color: Colors.black.withOpacity(0.55),
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
          child: Image.asset(asset, fit: BoxFit.cover),
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
