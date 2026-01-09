// lib/slides/slide_22.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide22 extends StatefulWidget {
  const Slide22({super.key});

  @override
  State<Slide22> createState() => _Slide22State();
}

class _Slide22State extends State<Slide22> with SingleTickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 1180),
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
        curve: const Interval(0.16, 0.98, curve: Curves.easeOutCubic),
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

    // ✅ una sola imagen a la derecha
    const rightImage = "assets/slide22/slide22.png";

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
                          title: "Runtime and Engineering – ctrlX WORKS",
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
                                  radius: 34,
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

                            // ================= RIGHT GLASS (ONE IMAGE) =================
                            Expanded(
                              flex: 56,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 34,
                                  padding: EdgeInsets.zero,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(34 * s),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: _FitImageToCardGlass(
                                            s: s,
                                            asset: rightImage,
                                            topInset: 12 * s,
                                            sideInset: 12 * s,
                                            bottomInset: 12 * s,
                                            blurOpacity: 0.12,
                                            overlayOpacity: 0.05,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                          left: 14 * s,
                                          right: 14 * s,
                                          bottom: 14 * s,
                                          child: _GlassLabelPill(
                                            s: s,
                                            text: "ctrlX WORKS – Vista general",
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(34 * s),
                                              border: Border.all(
                                                color:
                                                    Colors.white.withOpacity(0.14),
                                                width: 1.6,
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
                    fontSize: 50 * scale, // un toque menos para que nunca corte
                    height: 1.02,
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
    final hStyle = TextStyle(
      fontSize: 24 * s,
      fontWeight: FontWeight.w900,
      height: 1.08,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(
          blurRadius: 18,
          offset: const Offset(0, 10),
          color: Colors.black.withOpacity(0.18),
        ),
      ],
    );

    final base = TextStyle(
      fontSize: 16.4 * s,
      height: 1.28,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10 * s, top: 2 * s),
          child: Text("¿Cómo funciona?", style: hStyle),
        ),
        SizedBox(height: 12 * s),

        _InnerGlassPanel(
          s: s,
          padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletRichGlass(
                s: s,
                head: "Se instala",
                body: " en un ordenador con Windows 10 (64 bits).",
              ),
              SizedBox(height: 10 * s),
              _BulletRichGlass(
                s: s,
                head: "Permite seleccionar y configurar",
                body:
                    " las herramientas de ingeniería necesarias durante la instalación o posteriormente.",
              ),
              SizedBox(height: 10 * s),
              _BulletRichGlass(
                s: s,
                head: "Se conecta",
                body:
                    " a hardware real o utiliza el simulador virtual para configurar y programar.",
              ),
              SizedBox(height: 10 * s),
              _BulletRichGlass(
                s: s,
                head: "Accede",
                body:
                    " a bibliotecas preexistentes y permite crear aplicaciones personalizadas.",
              ),
            ],
          ),
        ),

        SizedBox(height: 12 * s),

        _InnerGlassPanel(
          s: s,
          padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
          child: RichText(
            text: TextSpan(
              style: base,
              children: [
                TextSpan(
                  text: "ctrlX WORKS",
                  style: base.copyWith(fontWeight: FontWeight.w900),
                ),
                const TextSpan(
                  text:
                      " es el punto de contacto central para las tareas de ingeniería en ",
                ),
                TextSpan(
                  text: "ctrlX AUTOMATION",
                  style: base.copyWith(fontWeight: FontWeight.w900),
                ),
                const TextSpan(
                  text:
                      ". Gracias a su estructura modular, se adapta con flexibilidad a requisitos específicos y habilita diversas herramientas de ingeniería.",
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12 * s),

        Expanded(
          child: _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Herramientas (ejemplos)",
                  style: TextStyle(
                    fontSize: 17.2 * s,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
                SizedBox(height: 10 * s),
                _LinkLine(s: s, text: "Ingeniería de PLC ctrlX"),
                SizedBox(height: 8 * s),
                _LinkLine(s: s, text: "Ingeniería de E/S de ctrlX"),
                SizedBox(height: 8 * s),
                _LinkLine(s: s, text: "Ingeniería de ctrlX DRIVE"),
                SizedBox(height: 8 * s),
                _LinkLine(s: s, text: "ctrlX Ingeniería de SEGURIDAD"),
                SizedBox(height: 8 * s),
                _LinkLine(s: s, text: "Diseñador de cámaras ctrlX MOTION"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkLine extends StatelessWidget {
  final double s;
  final String text;
  const _LinkLine({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16.2 * s,
        height: 1.2,
        fontWeight: FontWeight.w800,
        color: Colors.white.withOpacity(0.92),
        decoration: TextDecoration.underline,
        decorationThickness: 1.2,
        decorationColor: const Color(0xFF2EC4FF).withOpacity(0.75),
      ),
    );
  }
}

class _BulletRichGlass extends StatelessWidget {
  final double s;
  final String head;
  final String body;

  const _BulletRichGlass({
    required this.s,
    required this.head,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.92);

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
              color: const Color(0xFF2EC4FF).withOpacity(0.82),
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
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.2 * s,
                height: 1.26,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
              children: [
                TextSpan(
                  text: "$head:",
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

// ===================== GLASS LABEL PILL =====================

class _GlassLabelPill extends StatelessWidget {
  final double s;
  final String text;

  const _GlassLabelPill({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 10 * s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * s),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFF2EC4FF).withOpacity(0.10),
                Colors.white.withOpacity(0.08),
                const Color(0xFFFF2B2B).withOpacity(0.08),
              ],
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18 * s,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.95),
              letterSpacing: 0.2,
              shadows: [
                Shadow(
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                  color: Colors.black.withOpacity(0.22),
                ),
              ],
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
  final BoxFit fit;

  const _FitImageToCardGlass({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
    this.blurOpacity = 0.12,
    this.overlayOpacity = 0.05,
    this.fit = BoxFit.contain,
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
              fit: fit,
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
