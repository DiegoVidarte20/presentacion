// lib/slides/slide_25.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide25 extends StatefulWidget {
  const Slide25({super.key});

  @override
  State<Slide25> createState() => _Slide25State();
}

class _Slide25State extends State<Slide25> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));

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

    // ✅ 4 imágenes (cámbialas a tus paths reales)
    const img1 = "assets/slide25/slide25_1.png";
    const img2 = "assets/slide25/slide25_2.png";
    const img3 = "assets/slide25/slide25_3.png";
    const img4 = "assets/slide25/slide25_4.png";

    final cards = <_MotionCardData>[
      _MotionCardData(
        image: img1,
        section: "Bienes de consumo",
        bullets: const [
          "Máquinas de envoltura de flujo",
          "Máquinas de impresión flexográfica",
          "Laminadores",
          "Máquinas de embalaje",
          "Aplicaciones del cartón ondulado",
        ],
      ),
      _MotionCardData(
        image: img2,
        section: "Robótica y logística",
        bullets: const [
          "Robots cartesianos",
          "Robots delta",
          "Robots SCARA",
        ],
      ),
      _MotionCardData(
        image: img3,
        section: "Fabricación",
        bullets: const [
          "Máquinas dobladoras",
          "Máquinas de fabricación aditiva",
          "Máquinas dispensadoras",
        ],
      ),
      _MotionCardData(
        image: img4,
        section: "Semiconductor y electrónica",
        bullets: const [
          "Líneas de montaje",
          "Máquinas apiladoras para núcleos de baterías",
          "Máquinas de soldadura para celdas tipo bolsa",
        ],
      ),
    ];

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
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final w = c.maxWidth;
                            final h = c.maxHeight;

                            // 🔥 tamaño de cada tarjeta (responsive)
                            final cardW = (w * 0.235).clamp(240.0 * s, 360.0 * s);
                            final cardH = (h * 0.86).clamp(420.0 * s, h);

                            // 🧠 posiciones tipo “arco” (curvado, no fila recta)
                            // (x,y) en función del contenedor
                            final positions = <_CardPose>[
                              _CardPose(
                                x: w * 0.02,
                                y: h * 0.10,
                                rot: -0.030,
                              ),
                              _CardPose(
                                x: w * 0.27,
                                y: h * 0.03,
                                rot: -0.010,
                              ),
                              _CardPose(
                                x: w * 0.52,
                                y: h * 0.03,
                                rot: 0.010,
                              ),
                              _CardPose(
                                x: w * 0.77,
                                y: h * 0.10,
                                rot: 0.030,
                              ),
                            ];

                            // fallback si el ancho está ajustado (pantallas más chicas):
                            // hacemos “semi arco” con 2 arriba y 2 abajo
                            final useTwoRows = w < 1200 * s;
                            final poses = useTwoRows
                                ? <_CardPose>[
                                    _CardPose(x: w * 0.03, y: h * 0.06, rot: -0.020),
                                    _CardPose(x: w * 0.52, y: h * 0.03, rot: 0.015),
                                    _CardPose(x: w * 0.08, y: h * 0.52, rot: -0.010),
                                    _CardPose(x: w * 0.56, y: h * 0.56, rot: 0.020),
                                  ]
                                : positions;

                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                for (int i = 0; i < 4; i++)
                                  Positioned(
                                    left: poses[i].x,
                                    top: poses[i].y,
                                    child: _StaggerIn(
                                      controller: _c,
                                      index: i,
                                      child: Transform.rotate(
                                        angle: poses[i].rot,
                                        child: _GlassCard(
                                          s: s,
                                          radius: 36,
                                          padding: EdgeInsets.fromLTRB(18 * s, 16 * s, 18 * s, 16 * s),
                                          child: SizedBox(
                                            width: cardW,
                                            height: cardH,
                                            child: _MotionGlassCard(s: s, data: cards[i]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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

// ===================== DATA =====================

class _MotionCardData {
  final String image;
  final String section;
  final List<String> bullets;
  const _MotionCardData({
    required this.image,
    required this.section,
    required this.bullets,
  });
}

class _CardPose {
  final double x;
  final double y;
  final double rot;
  const _CardPose({required this.x, required this.y, required this.rot});
}

// ===================== STAGGER ANIM =====================

class _StaggerIn extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _StaggerIn({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = (0.12 + index * 0.08).clamp(0.0, 1.0);
    final end = (start + 0.80).clamp(0.0, 1.0);

    final anim = CurvedAnimation(
      parent: controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    final slide = Tween<Offset>(
      begin: Offset(0.03 * (index.isEven ? -1 : 1), 0.06),
      end: Offset.zero,
    ).animate(anim);

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Interval(start, (start + 0.35).clamp(0.0, 1.0), curve: Curves.easeOut)),
    );

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}

// ===================== CARD CONTENT =====================


class _MotionGlassCard extends StatelessWidget {
  final double s;
  final _MotionCardData data;

  const _MotionGlassCard({required this.s, required this.data});

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(
      fontSize: 26 * s,
      fontWeight: FontWeight.w900,
      height: 1.0,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(
          blurRadius: 16,
          offset: const Offset(0, 8),
          color: Colors.black.withOpacity(0.22),
        ),
      ],
    );

    final base = TextStyle(
      fontSize: 15.8 * s,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    // ✅ aire extra SOLO para los textos que se veían pegados
    final textPad = EdgeInsets.symmetric(horizontal: 10 * s);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: textPad,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("ctrlX MOTION", style: title),
              SizedBox(height: 10 * s),
              Text(
                "ctrlX MOTION es perfectamente adecuado para las siguientes aplicaciones y máquinas",
                style: base,
              ),
            ],
          ),
        ),

        SizedBox(height: 14 * s),

        // imagen
        _InnerGlassPanel(
          s: s,
          padding: EdgeInsets.all(10 * s),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18 * s),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _FitImageToCardGlass(
                      s: s,
                      asset: data.image,
                      topInset: 0,
                      sideInset: 0,
                      bottomInset: 0,
                      blurOpacity: 0.10,
                      overlayOpacity: 0.08,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18 * s),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 14 * s),

        Padding(
          padding: textPad,
          child: Text(
            data.section,
            style: title.copyWith(fontSize: 20 * s, height: 1.05),
          ),
        ),

        SizedBox(height: 10 * s),

        Expanded(
          child: _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < data.bullets.length; i++) ...[
                  _BulletLine(s: s, text: data.bullets[i]),
                  if (i != data.bullets.length - 1) SizedBox(height: 8 * s),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class _BulletLine extends StatelessWidget {
  final double s;
  final String text;
  const _BulletLine({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.92);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6.5 * s),
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
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 10 * s),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.8 * s,
              height: 1.22,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ],
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
            padding: EdgeInsets.fromLTRB(sideInset * s, topInset * s, sideInset * s, bottomInset * s),
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
        child: Icon(Icons.image_rounded, size: 54 * s, color: Colors.white.withOpacity(0.70)),
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
    final paint = Paint()..color = Colors.white..strokeWidth = 1;
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
