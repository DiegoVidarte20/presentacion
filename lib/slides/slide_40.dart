// lib/slides/slide_40.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide40 extends StatefulWidget {
  const Slide40({super.key});

  @override
  State<Slide40> createState() => _Slide40State();
}

class _Slide40State extends State<Slide40> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _imgIn;

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

    _imgIn = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
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
    const imgAsset = "assets/slide40/slide40.png"; // <-- tu imagen

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
                          title: "CTRL X CORE como PLC esclavo",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: SlideTransition(
                          position: _imgIn,
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                // ✅ grande, sin vacío
                                maxWidth: 1240 * s,
                                maxHeight: 620 * s,
                              ),
                              child: _GlassCard(
                                s: s,
                                radius: 46,
                                padding: EdgeInsets.fromLTRB(18 * s, 18 * s, 18 * s, 18 * s),
                                child: _CroppedImagePanel(
                                  s: s,
                                  asset: imgAsset,

                                  // ✅ recorte leve para matar el borde celeste
                                  cropLeftFactor: 0.030,
                                  cropRightFactor: 0.030,
                                  cropTopFactor: 0.030,
                                  cropBottomFactor: 0.030,

                                  fit: BoxFit.contain,
                                ),
                              ),
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

// ===================== IMAGE (CROPPED ALL SIDES) =====================
class _CroppedImagePanel extends StatelessWidget {
  final double s;
  final String asset;
  final double cropLeftFactor;   // 0..1
  final double cropRightFactor;  // 0..1
  final double cropTopFactor;    // 0..1
  final double cropBottomFactor; // 0..1
  final BoxFit fit;

  const _CroppedImagePanel({
    required this.s,
    required this.asset,
    this.cropLeftFactor = 0.0,
    this.cropRightFactor = 0.0,
    this.cropTopFactor = 0.0,
    this.cropBottomFactor = 0.0,
    this.fit = BoxFit.contain,
  });

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
            child: Padding(
              padding: EdgeInsets.all(10 * s),
              child: LayoutBuilder(
                builder: (context, c) {
                  final wl = (c.maxWidth * cropLeftFactor).clamp(0.0, c.maxWidth - 1);
                  final wr = (c.maxWidth * cropRightFactor).clamp(0.0, c.maxWidth - 1);
                  final ht = (c.maxHeight * cropTopFactor).clamp(0.0, c.maxHeight - 1);
                  final hb = (c.maxHeight * cropBottomFactor).clamp(0.0, c.maxHeight - 1);

                  final visW = (c.maxWidth - wl - wr).clamp(1.0, c.maxWidth);
                  final visH = (c.maxHeight - ht - hb).clamp(1.0, c.maxHeight);

                  return ClipRect(
                    child: Align(
                      alignment: Alignment.center,
                      widthFactor: visW / c.maxWidth,
                      heightFactor: visH / c.maxHeight,
                      child: Transform.translate(
                        offset: Offset(-(wl - wr) / 2, -(ht - hb) / 2),
                        child: Image.asset(
                          asset,
                          fit: fit,
                          alignment: Alignment.center,
                          filterQuality: FilterQuality.high,
                          errorBuilder: (_, __, ___) => _ImageFallbackGlass(s: s),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
            border: Border.all(color: Colors.white.withOpacity(0.10), width: 1.2),
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
                      fontSize: 46 * scale,
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
