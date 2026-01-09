// lib/slides/slide_26.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide26 extends StatefulWidget {
  const Slide26({super.key});

  @override
  State<Slide26> createState() => _Slide26State();
}

class _Slide26State extends State<Slide26> with SingleTickerProviderStateMixin {
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
      duration: const Duration(milliseconds: 1200),
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
            curve: const Interval(0.14, 0.96, curve: Curves.easeOutCubic),
          ),
        );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.18, 0.98, curve: Curves.easeOutCubic),
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
    return (w / 1366.0).clamp(0.78, 1.22);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    // ✅ Cuando tengas tu imagen, solo cambia este path (si no existe, muestra placeholder)
    const rightImg = "assets/slide26/slide26_1.png";

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
                          title: "Motion, Robotics and CNC",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ================= LEFT (TEXT) =================
                            Expanded(
                              flex: 38,
                              child: SlideTransition(
                                position: _leftIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 38,
                                  padding: EdgeInsets.fromLTRB(
                                    18 * s,
                                    16 * s,
                                    18 * s,
                                    16 * s,
                                  ),
                                  child: _LeftContent(s: s),
                                ),
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ================= RIGHT (IMAGE SPACE) =================
                            Expanded(
                              flex: 62,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 44,
                                  padding: EdgeInsets.fromLTRB(
                                    14 * s,
                                    14 * s,
                                    14 * s,
                                    14 * s,
                                  ),
                                  child: _RightImageSpace(
                                    s: s,
                                    asset: rightImg,
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
    final h = TextStyle(
      fontSize: 22.0 * s, // sube base pero lo controla FittedBox (no revienta)
      height: 1.05, // más compacto
      fontWeight: FontWeight.w900,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(
          blurRadius: 14,
          offset: const Offset(0, 8),
          color: Colors.black.withOpacity(0.20),
        ),
      ],
    );

    final base = TextStyle(
      fontSize: 16.0 * s,
      height: 1.26,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    return Padding(
       padding: EdgeInsets.fromLTRB(10 * s, 8 * s, 6 * s, 0), // 👈 top/left
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
            child: Text(
              "Las características de ctrlX MOTION:",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: h.copyWith(
                fontSize:
                    21.0 *
                    s, // un toque menos (antes 19.8*s, pero aquí va dentro de FittedBox)
                height: 1.05,
              ),
            ),
          ),
        ),

        SizedBox(height: 12 * s),

        _InnerGlassPanel(
          s: s,
          padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _Bullet(
                text: "Control para máquinas complejas de alta producción",
              ),
              _Bullet(text: "Alta velocidad y máximo rendimiento"),
              _Bullet(text: "Máxima escalabilidad"),
              _Bullet(text: "Libre elección del lenguaje de programación"),
              _Bullet(text: "Ingeniería sencilla e intuitiva"),
            ],
          ),
        ),

        SizedBox(height: 18 * s),
        Text("Aplicaciones y funciones tecnológicas", style: h),
        SizedBox(height: 12 * s),

        Expanded(
          child: _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: DefaultTextStyle(
              style: base,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Bullet(text: "Aplicación ctrlX MOTION"),
                  _Bullet(text: "Robótica cartesiana"),
                  _Bullet(text: "Entorno de desarrollo integrado"),
                  _Bullet(text: "Funciones de la tecnología"),
                ],
              ),
            ),
          ),
        ),
      ],
      )
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    // usa DefaultTextStyle del padre si existe
    final s = (context.findAncestorWidgetOfExactType<_LeftContent>()?.s) ?? 1.0;
    final textColor = Colors.white.withOpacity(0.92);

    return Padding(
      padding: EdgeInsets.only(bottom: 10 * s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 7 * s),
            child: Container(
              width: 6.2 * s,
              height: 6.2 * s,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2EC4FF).withOpacity(0.82),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10 * s),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0 * s,
                height: 1.26,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== RIGHT IMAGE SPACE =====================

class _RightImageSpace extends StatelessWidget {
  final double s;
  final String asset;

  const _RightImageSpace({required this.s, required this.asset});

  @override
  Widget build(BuildContext context) {
    final r = 34 * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: Stack(
        children: [
          // fondo interno glass suave
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(r),
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
          ),

          // ✅ espacio para tu imagen (si no existe, placeholder)
          Positioned.fill(
            child: _FitImageToCardGlass(
              s: s,
              asset: asset,
              topInset: 14 * s,
              sideInset: 14 * s,
              bottomInset: 14 * s,
              blurOpacity: 0.10,
              overlayOpacity: 0.06,
              fit: BoxFit.contain,
            ),
          ),

          // borde suave
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

          // hint glass (opcional, se ve paja y no estorba)
          Positioned(
            left: 18 * s,
            right: 18 * s,
            bottom: 18 * s,
            child: _GlassHintPill(s: s, text: "Espacio reservado para imagen"),
          ),
        ],
      ),
    );
  }
}

class _GlassHintPill extends StatelessWidget {
  final double s;
  final String text;

  const _GlassHintPill({required this.s, required this.text});

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
            color: Colors.white.withOpacity(0.09),
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
                        Colors.white.withOpacity(0.11),
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
      clipBehavior: Clip.antiAlias,
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
    this.fit = BoxFit.cover,
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
          size: 74 * s,
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
