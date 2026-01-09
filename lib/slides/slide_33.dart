// lib/slides/slide_33.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide33 extends StatefulWidget {
  const Slide33({super.key});

  @override
  State<Slide33> createState() => _Slide33State();
}

class _Slide33State extends State<Slide33> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rightIn;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1180));

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _scale = Tween<double>(begin: 0.988, end: 1.0).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.08, 1.0, curve: Curves.easeOutBack)),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.00, 0.45, curve: Curves.easeOutCubic)),
    );

    _leftIn = Tween<Offset>(begin: const Offset(-0.06, 0.04), end: Offset.zero).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.14, 0.96, curve: Curves.easeOutCubic)),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.18, 0.98, curve: Curves.easeOutCubic)),
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

    // === ASSETS (cámbialos a tus rutas reales) ===
    const leftTopImg = "assets/slide33/slide33_1.png";
    const leftBottomImg = "assets/slide33/slide33_2.png";
    const rightTopImg = "assets/slide33/slide33_3.png";
    const rightBottomImg = "assets/slide33/slide33_4.jpg";

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
                          title: "CtrlX IPC",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final w = c.maxWidth;
                            final stacked = w < 1180 * s;

                            final leftCol = SlideTransition(
                              position: _leftIn,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: _GlassCard(
                                      s: s,
                                      radius: 46,
                                      padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
                                      child: _ImageOnlyCard(s: s, asset: leftTopImg),
                                    ),
                                  ),
                                  SizedBox(height: 18 * s),
                                  Expanded(
                                    child: _GlassCard(
                                      s: s,
                                      radius: 46,
                                      padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
                                      child: _ImageOnlyCard(s: s, asset: leftBottomImg),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            final rightCol = SlideTransition(
                              position: _rightIn,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: _GlassCard(
                                      s: s,
                                      radius: 46,
                                      padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
                                      child: _ImageOnlyCard(s: s, asset: rightTopImg),
                                    ),
                                  ),
                                  SizedBox(height: 18 * s),
                                  Expanded(
                                    child: _GlassCard(
                                      s: s,
                                      radius: 46,
                                      padding: EdgeInsets.fromLTRB(18 * s, 18 * s, 18 * s, 18 * s),
                                      child: _RightBottomTextPlusImage(
                                        s: s,
                                        asset: rightBottomImg,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                            if (!stacked) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(flex: 50, child: leftCol),
                                  SizedBox(width: 18 * s),
                                  Expanded(flex: 50, child: rightCol),
                                ],
                              );
                            }

                            // Responsive stacked
                            return Column(
                              children: [
                                Expanded(flex: 52, child: leftCol),
                                SizedBox(height: 18 * s),
                                Expanded(flex: 48, child: rightCol),
                              ],
                            );
                          },
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

// ===================== RIGHT BOTTOM (TEXT + IMAGE) =====================

class _RightBottomTextPlusImage extends StatelessWidget {
  final double s;
  final String asset;
  const _RightBottomTextPlusImage({required this.s, required this.asset});

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(
      fontSize: 22 * s,
      height: 1.08,
      fontWeight: FontWeight.w900,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(blurRadius: 14, offset: const Offset(0, 8), color: Colors.black.withOpacity(0.20)),
      ],
    );

    final bullet = TextStyle(
      fontSize: 16.0 * s,
      height: 1.30,
      fontWeight: FontWeight.w800,
      color: Colors.white.withOpacity(0.92),
    );

    Widget b(String t) => Padding(
          padding: EdgeInsets.only(bottom: 10 * s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.5 * s),
                child: Container(
                  width: 8 * s,
                  height: 8 * s,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF2EC4FF).withOpacity(0.92),
                  ),
                ),
              ),
              SizedBox(width: 10 * s),
              Expanded(child: Text(t, style: bullet)),
            ],
          ),
        );

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final stacked = w < 520 * s;

        final textBlock = _InnerGlassPanel(
          s: s,
          padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // si no quieres título acá, bórralo
              Text("Características", style: title),
              SizedBox(height: 12 * s),
              b("PC industrial escalable y robusto"),
              b("IPC con NVIDIA: maximizando el rendimiento para visión e inteligencia artificial"),
              b("Interfaz CDI+: la solución inteligente de un solo cable para HMI."),
            ],
          ),
        );

        final imgBlock = ClipRRect(
          borderRadius: BorderRadius.circular(26 * s),
          child: _FitImageToCardGlass(
            s: s,
            asset: asset,
            topInset: 10 * s,
            sideInset: 10 * s,
            bottomInset: 10 * s,
            blurOpacity: 0.10,
            overlayOpacity: 0.05,
            fit: BoxFit.contain,
          ),
        );

        if (!stacked) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 48, child: textBlock),
              SizedBox(width: 14 * s),
              Expanded(flex: 52, child: imgBlock),
            ],
          );
        }

        return Column(
          children: [
            Expanded(flex: 54, child: imgBlock),
            SizedBox(height: 14 * s),
            Expanded(flex: 46, child: textBlock),
          ],
        );
      },
    );
  }
}

// ===================== IMAGE ONLY CARD =====================

class _ImageOnlyCard extends StatelessWidget {
  final double s;
  final String asset;
  const _ImageOnlyCard({required this.s, required this.asset});

  @override
  Widget build(BuildContext context) {
    final r = 34 * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
              child: Container(color: Colors.white.withOpacity(0.05)),
            ),
          ),
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
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r),
                border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
              ),
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
          padding: EdgeInsets.symmetric(horizontal: 22 * scale, vertical: 14 * scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
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
                child: Padding(
                  padding: EdgeInsets.only(right: 8 * scale),
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
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.8),
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
        Positioned.fill(child: Container(color: Colors.black.withOpacity(overlayOpacity))),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.fromLTRB(sideInset, topInset, sideInset, bottomInset),
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
        child: Icon(Icons.image_rounded, size: 88 * s, color: Colors.white.withOpacity(0.70)),
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
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.step != step;
}
