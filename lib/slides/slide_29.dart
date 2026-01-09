// lib/slides/slide_29.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide29 extends StatefulWidget {
  const Slide29({super.key});

  @override
  State<Slide29> createState() => _Slide29State();
}

class _Slide29State extends State<Slide29> with SingleTickerProviderStateMixin {
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
    const rightImg = "assets/slide29/slide29.png"; // <-- tu imagen derecha

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
                          title: "SafeLogic and SafeMotion",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final w = c.maxWidth;
                            final stacked = w < 1100 * s;

                            final left = SlideTransition(
                              position: _leftIn,
                              child: _GlassCard(
                                s: s,
                                radius: 46,
                                padding: EdgeInsets.fromLTRB(18 * s, 18 * s, 18 * s, 18 * s),
                                child: _LeftScalingTable(s: s),
                              ),
                            );

                            final right = SlideTransition(
                              position: _rightIn,
                              child: _GlassCard(
                                s: s,
                                radius: 46,
                                padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
                                child: _RightImagePanel(s: s, asset: rightImg),
                              ),
                            );

                            if (!stacked) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(flex: 42, child: left),
                                  SizedBox(width: 18 * s),
                                  Expanded(flex: 58, child: right),
                                ],
                              );
                            }

                            return Column(
                              children: [
                                Expanded(flex: 52, child: left),
                                SizedBox(height: 18 * s),
                                Expanded(flex: 48, child: right),
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

// ===================== LEFT CONTENT (NO OVERFLOW) =====================

class _LeftScalingTable extends StatelessWidget {
  final double s;
  const _LeftScalingTable({required this.s});

  @override
  Widget build(BuildContext context) {
    final title = TextStyle(
      fontSize: 20.5 * s,
      height: 1.05,
      fontWeight: FontWeight.w900,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(blurRadius: 14, offset: const Offset(0, 8), color: Colors.black.withOpacity(0.20)),
      ],
    );

    final base = TextStyle(
      fontSize: 16.0 * s,
      height: 1.26,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    // ✅ data (tu slide)
    const rows = [
      _KVRow(k: "Característica", v: "Escalamiento Horizontal (Out)"),
      _KVRow(k: "Acción", v: "Añadir nuevos equipos a la red."),
      _KVRow(k: "Límite", v: "Prácticamente infinito."),
      _KVRow(k: "Disponibilidad", v: "Si un nodo falla, los demás siguen trabajando."),
      _KVRow(k: "Costo", v: "Puedes usar hardware estándar y económico."),
      _KVRow(k: "Complejidad", v: "Mayor (requiere gestionar una red distribuida)."),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Título grande con padding (para que NO se corte)
        Padding(
          padding: EdgeInsets.only(left: 12 * s, top: 9 * s, right: 6 * s),
          child: SizedBox(
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text("Escalamiento Horizontal", style: title),
            ),
          ),
        ),
        SizedBox(height: 12 * s),

        Expanded(
          child: _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 14 * s, 14 * s, 14 * s),
            child: DefaultTextStyle(
              style: base,
              child: Column(
                children: [
                  _TwoColHeader(s: s),
                  SizedBox(height: 10 * s),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: rows.map((e) => _TwoColRow(s: s, k: e.k, v: e.v)).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _KVRow {
  final String k;
  final String v;
  const _KVRow({required this.k, required this.v});
}

class _TwoColHeader extends StatelessWidget {
  final double s;
  const _TwoColHeader({required this.s});

  @override
  Widget build(BuildContext context) {
    final th = TextStyle(
      fontSize: 15.0 * s,
      fontWeight: FontWeight.w900,
      color: Colors.white.withOpacity(0.92),
      height: 1.1,
      letterSpacing: 0.2,
    );

    return _InnerGlassPanel(
      s: s,
      padding: EdgeInsets.fromLTRB(12 * s, 10 * s, 12 * s, 10 * s),
      child: Row(
        children: [
          SizedBox(width: 190 * s, child: Text("Característica", style: th)),
          Expanded(child: Text("Descripción", style: th)),
        ],
      ),
    );
  }
}

class _TwoColRow extends StatelessWidget {
  final double s;
  final String k;
  final String v;
  const _TwoColRow({required this.s, required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10 * s),
      child: _InnerGlassPanel(
        s: s,
        padding: EdgeInsets.fromLTRB(12 * s, 12 * s, 12 * s, 12 * s),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 190 * s,
              child: Text(
                k,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white.withOpacity(0.95),
                  height: 1.18,
                ),
              ),
            ),
            SizedBox(width: 12 * s),
            Expanded(
              child: Text(
                v,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.90),
                  height: 1.26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== RIGHT IMAGE =====================

class _RightImagePanel extends StatelessWidget {
  final double s;
  final String asset;
  const _RightImagePanel({required this.s, required this.asset});

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
