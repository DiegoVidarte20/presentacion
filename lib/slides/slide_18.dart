// lib/slides/slide_18.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide18 extends StatefulWidget {
  const Slide18({super.key});

  @override
  State<Slide18> createState() => _Slide18State();
}

class _Slide18State extends State<Slide18> with SingleTickerProviderStateMixin {
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
        curve: const Interval(0.12, 0.85, curve: Curves.easeOutCubic),
      ),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
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
    return (w / 1366.0).clamp(0.80, 1.18);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";
    const rightImage = "assets/slide18/slide18.jpg"; // 👈 tu imagen derecha

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
                            // ===== LEFT CARD (text) =====
                            Expanded(
                              flex: 36,
                              child: SlideTransition(
                                position: _leftIn,
                                child: _WhiteCard(
                                  s: s,
                                  radius: 30,
                                  padding: EdgeInsets.fromLTRB(
                                    20 * s,
                                    18 * s,
                                    18 * s,
                                    16 * s,
                                  ),
                                  child: _LeftContent(s: s),
                                ),
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ===== RIGHT CARD (image) =====
                            Expanded(
                              flex: 64,
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

// ===================== LEFT CONTENT =====================

class _LeftContent extends StatelessWidget {
  final double s;
  const _LeftContent({required this.s});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "ctrlX sin IEC (Programación\nModerna / IT)",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22 * s,
              fontWeight: FontWeight.w900,
              height: 1.12,
              color: const Color(0xFF0B1B2B).withOpacity(0.96),
            ),
          ),
        ),
        SizedBox(height: 14 * s),

        Text(
          "Ventajas:",
          style: TextStyle(
            fontSize: 18 * s,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0B1B2B).withOpacity(0.92),
          ),
        ),
        SizedBox(height: 8 * s),

        _BulletRich(
          s: s,
          head: "Flexibilidad total:",
          body:
              " Uso de software de código abierto y bibliotecas externas (ej. OpenCV para visión o TensorFlow para IA).",
        ),
        SizedBox(height: 8 * s),
        _BulletRich(
          s: s,
          head: "Ingeniería web:",
          body:
              " Programación mediante Visual Coding (basado en bloques) o Textual Coding directamente desde el navegador.",
        ),

        SizedBox(height: 16 * s),

        Text(
          "Comunicación:",
          style: TextStyle(
            fontSize: 18 * s,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0B1B2B).withOpacity(0.92),
          ),
        ),
        SizedBox(height: 8 * s),

        Text(
          "Todo se integra mediante el ctrlX Data Layer, lo que permite que una app en Python interactúe con el hardware sin pasar por un programa IEC.",
          style: TextStyle(
            fontSize: 16.8 * s,
            height: 1.26,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0B1B2B).withOpacity(0.90),
          ),
        ),
      ],
    );
  }
}

class _BulletRich extends StatelessWidget {
  final double s;
  final String head;
  final String body;

  const _BulletRich({
    required this.s,
    required this.head,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = const Color(0xFF0B1B2B).withOpacity(0.90);

    return Row(
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
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.8 * s,
                height: 1.24,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
              children: [
                TextSpan(
                  text: head,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
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
              opacity: 0.20,
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => fallback(),
              ),
            ),
          ),
        ),
        Positioned.fill(child: Container(color: Colors.black.withOpacity(0.03))),
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
