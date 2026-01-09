// lib/slides/slide_20.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide20 extends StatefulWidget {
  const Slide20({super.key});

  @override
  State<Slide20> createState() => _Slide20State();
}

class _Slide20State extends State<Slide20> with SingleTickerProviderStateMixin {
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

    // ===== RIGHT (3 images) =====
    const imgTopLeft = "assets/slide20/slide20_1.jpg";
    const imgTopRight = "assets/slide20/slide20_2.jpg";
    const imgBottom = "assets/slide20/slide20_3.jpg";

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
                        child: _HeaderGlass(
                          scale: s,
                          title: "Programación IEC y NO-IEC",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ================= LEFT GLASS (TEXT) =================
                            Expanded(
                              flex: 44,
                              child: SlideTransition(
                                position: _leftIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 30,
                                  padding: EdgeInsets.fromLTRB(
                                    18 * s,
                                    16 * s,
                                    18 * s,
                                    16 * s,
                                  ),
                                  child: _LeftContentGlass(s: s),
                                ),
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ================= RIGHT GLASS (3 IMAGES) =================
                            Expanded(
                              flex: 56,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 34,
                                  padding: EdgeInsets.fromLTRB(
                                    14 * s,
                                    14 * s,
                                    14 * s,
                                    14 * s,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 52,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _ImagePaneGlass(
                                                s: s,
                                                asset: imgTopLeft,
                                                radius: 18,
                                              ),
                                            ),
                                            SizedBox(width: 12 * s),
                                            Expanded(
                                              child: _ImagePaneGlass(
                                                s: s,
                                                asset: imgTopRight,
                                                radius: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 12 * s),
                                      Expanded(
                                        flex: 48,
                                        child: _ImagePaneGlass(
                                          s: s,
                                          asset: imgBottom,
                                          radius: 22,
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
                    ],
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

// ===================== HEADER GLASS =====================

class _HeaderGlass extends StatelessWidget {
  final double scale;
  final String title;

  const _HeaderGlass({required this.scale, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22 * scale,
            vertical: 14 * scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(
              color: Colors.white.withOpacity(0.14),
              width: 1.6,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                blurRadius: 26 * scale,
                offset: Offset(0, 12 * scale),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 10 * scale,
                height: 34 * scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2EC4FF).withOpacity(0.95),
                      const Color(0xFFFF2B2B).withOpacity(0.85),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 14 * scale),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 52 * scale,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                    color: Colors.white.withOpacity(0.96),
                    shadows: [
                      Shadow(
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ],
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

// ===================== LEFT CONTENT (GLASS) =====================

class _LeftContentGlass extends StatelessWidget {
  final double s;
  const _LeftContentGlass({required this.s});

  @override
  Widget build(BuildContext context) {
    // Esto hace que el “1.” y “2.” NO se vean “salidos”
    // y además alinea bullets/texto debajo del título (bonito y limpio).
    final indent = (34 + 12) * s; // ancho badge + gap

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitleGlass(s: s, n: "1", title: "Entorno de Software"),
        SizedBox(height: 10 * s),

        Padding(
          padding: EdgeInsets.only(left: indent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletGlass(
                s: s,
                textSpans: [
                  _b(s, "ctrlX PLC Engineering: "),
                  _n(
                    s,
                    "Es el entorno basado en CODESYS (líder en software de control independiente del fabricante) adaptado por Rexroth con librerías específicas.",
                  ),
                ],
              ),
              SizedBox(height: 10 * s),
              _BulletGlass(
                s: s,
                textSpans: [
                  _b(s, "Integración: "),
                  _n(
                    s,
                    "Se accede a través de la caja de herramientas ctrlX WORKS, que permite configurar tanto hardware físico (ctrlX CORE) como instancias virtuales para pruebas.",
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 20 * s), // 👈 más aire, para que no “pegue” con el 2.

        _SectionTitleGlass(
          s: s,
          n: "2",
          title: "Lenguajes Soportados (IEC 61131-3)",
        ),
        SizedBox(height: 10 * s),

        Padding(
          padding: EdgeInsets.only(left: indent),
          child: _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "El sistema permite el uso de los cinco lenguajes estándar de PLC:",
                  style: TextStyle(
                    fontSize: 15.8 * s,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.90),
                  ),
                ),
                SizedBox(height: 10 * s),

                _BulletGlass(
                  s: s,
                  dotOpacity: 0.82,
                  textSpans: [
                    _b(s, "Texto Estructurado (ST): "),
                    _n(s, "Incluye versiones extendidas como "),
                    _b(s, "ExST"),
                    _n(s, " (Extended Structured Text)."),
                  ],
                ),
                SizedBox(height: 8 * s),
                _BulletGlass(
                  s: s,
                  textSpans: [_b(s, "Diagrama de Escalera (LD/Ladder).")],
                ),
                SizedBox(height: 8 * s),
                _BulletGlass(
                  s: s,
                  textSpans: [_b(s, "Diagrama de Bloques de Funciones (FBD).")],
                ),
                SizedBox(height: 8 * s),
                _BulletGlass(
                  s: s,
                  textSpans: [
                    _b(s, "Diagrama de Funciones Secuenciales (SFC)."),
                  ],
                ),
                SizedBox(height: 8 * s),
                _BulletGlass(
                  s: s,
                  textSpans: [_b(s, "Lista de Instrucciones (IL).")],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static TextSpan _b(double s, String t) => TextSpan(
        text: t,
        style: TextStyle(
          fontSize: 15.8 * s,
          height: 1.25,
          fontWeight: FontWeight.w900,
          color: Colors.white.withOpacity(0.96),
        ),
      );

  static TextSpan _n(double s, String t) => TextSpan(
        text: t,
        style: TextStyle(
          fontSize: 15.8 * s,
          height: 1.25,
          fontWeight: FontWeight.w700,
          color: Colors.white.withOpacity(0.90),
        ),
      );
}

class _SectionTitleGlass extends StatelessWidget {
  final double s;
  final String n;
  final String title;

  const _SectionTitleGlass({
    required this.s,
    required this.n,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final badge = 34 * s;

    return Padding(
      // 👈 este padding evita que quede demasiado pegado al borde del card
      padding: EdgeInsets.only(left: 9 * s, top: 7 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge “1 / 2” SIN sombra (porque se corta con ClipRRect)
          Container(
            width: badge,
            height: badge,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12 * s),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.16),
                  Colors.white.withOpacity(0.06),
                  Colors.black.withOpacity(0.10),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 1.2,
              ),
            ),
            child: Text(
              n,
              style: TextStyle(
                fontSize: 18.5 * s,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.96),
              ),
            ),
          ),
          SizedBox(width: 12 * s),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4 * s),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20 * s,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                  color: Colors.white.withOpacity(0.96),
                  shadows: [
                    Shadow(
                      blurRadius: 14,
                      offset: const Offset(0, 8),
                      color: Colors.black.withOpacity(0.18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _BulletGlass extends StatelessWidget {
  final double s;
  final List<TextSpan> textSpans;
  final double dotOpacity;

  const _BulletGlass({
    required this.s,
    required this.textSpans,
    this.dotOpacity = 0.80,
  });

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFF2EC4FF).withOpacity(dotOpacity),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.18),
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 10 * s),
        Expanded(child: RichText(text: TextSpan(children: textSpans))),
      ],
    );
  }
}

// ===================== RIGHT IMAGE PANE (GLASS) =====================

class _ImagePaneGlass extends StatelessWidget {
  final double s;
  final String asset;
  final double radius;

  const _ImagePaneGlass({
    required this.s,
    required this.asset,
    this.radius = 18,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 16 * s, sigmaY: 16 * s),
              child: Container(color: Colors.white.withOpacity(0.06)),
            ),
          ),
          Positioned.fill(
            child: _FitImageToCardGlass(
              s: s,
              asset: asset,
              topInset: 8 * s,
              sideInset: 8 * s,
              bottomInset: 8 * s,
              blurOpacity: 0.10,
              overlayOpacity: 0.04,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.14),
                  width: 1.6,
                ),
              ),
            ),
          ),
        ],
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
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: Colors.white.withOpacity(0.14),
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

// ===================== INNER GLASS PANEL =====================

class _InnerGlassPanel extends StatelessWidget {
  final double s;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _InnerGlassPanel({
    required this.s,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22 * s),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ===================== IMAGE FIT (GLASS) =====================

class _FitImageToCardGlass extends StatelessWidget {
  final double s;
  final String asset;
  final double topInset;
  final double sideInset;
  final double bottomInset;
  final double blurOpacity;
  final double overlayOpacity;

  const _FitImageToCardGlass({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
    this.blurOpacity = 0.10,
    this.overlayOpacity = 0.04,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => _ImageFallbackGlass(s: s);

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
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(overlayOpacity)),
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

class _ImageFallbackGlass extends StatelessWidget {
  final double s;
  const _ImageFallbackGlass({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Icon(
          Icons.image_rounded,
          size: 54 * s,
          color: Colors.white.withOpacity(0.70),
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
                  Colors.black.withOpacity(0.16),
                  Colors.black.withOpacity(0.60),
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
