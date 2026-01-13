// lib/slides/slide_15.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide15 extends StatefulWidget {
  const Slide15({super.key});

  @override
  State<Slide15> createState() => _Slide15State();
}

class _Slide15State extends State<Slide15> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _topCardIn;
  late final Animation<Offset> _bottomCardIn;

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

    _topCardIn = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.12, 0.80, curve: Curves.easeOutCubic),
      ),
    );

    _bottomCardIn =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.18, 1.00, curve: Curves.easeOutCubic),
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

    // ===== assets (cámbialos a los reales) =====
    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    // ✅ 1 sola imagen arriba (tira completa con equipos + texto debajo)
    const topStrip = "assets/slide15/slide15_1.jpeg"; // o .jpg

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
                        child: _TopHeadline(s: s, title: "Drives and Motors"),
                      ),
                      SizedBox(height: 14 * s),

                      // ===== TOP IMAGE STRIP (1 sola imagen) =====
                      SlideTransition(
                        position: _topCardIn,
                        child: SizedBox(
                          height: 230 * s,
                          child: _GlassCard(
                            s: s,
                            radius: 30,
                            padding: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30 * s),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: _FitImageToCard(
                                      s: s,
                                      asset: topStrip,
                                      // aquí NO reservamos header, porque el título está afuera
                                      topInset: 10 * s,
                                      sideInset: 10 * s,
                                      bottomInset: 10 * s,
                                    ),
                                  ),
                                  // borde interno azul pro
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30 * s),
                                        border: Border.all(
                                          color: const Color(0xFF59D7FF)
                                              .withOpacity(0.55),
                                          width: 2.2,
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

                      SizedBox(height: 14 * s),

                      // ===== BOTTOM BIG CARD (3 columnas texto) =====
                      Expanded(
                        child: SlideTransition(
                          position: _bottomCardIn,
                          child: _GlassCard(
                            s: s,
                            radius: 32,
                            padding: EdgeInsets.fromLTRB(
                              18 * s,
                              16 * s,
                              18 * s,
                              16 * s,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32 * s),
                              child: Stack(
                                children: [
                                  // Watermarks suaves (simulan los circulitos de la imagen)
                                  Positioned.fill(
                                    child: IgnorePointer(
                                      child: Opacity(
                                        opacity: 0.12,
                                        child: CustomPaint(
                                          painter: _WatermarkPainter(),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: _BulletColumn(
                                          s: s,
                                          title: "Huella Mínima",
                                          bullets: const [
                                            "Ahorro de espacio: -50% en Accionamiento, -100% en Control",
                                            "Concepto de alimentación flexible, incl. convertidor o como fuente de alimentación.",
                                            "Amplia gama de accionamientos de doble eje: ahorro de espacio y menor esfuerzo de instalación",
                                            "Gabinete de control de 300 mm",
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _BulletColumn(
                                          s: s,
                                          title: "Escalable y Consistente",
                                          bullets: const [
                                            "Rango de potencia: Accionamiento 6...375 A",
                                            "Desde un eje de nivel de entrada con control de valor de consigna hasta sistema de movimiento completo",
                                            "Menos accesorios gracias a, p. ej., barra colectora de CC integrada y tecnología de un solo cable.",
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _BulletColumn(
                                          s: s,
                                          title: "Rendimiento y Productividad",
                                          bullets: const [
                                            "Décadas de experiencia en aplicaciones utilizables en funciones de software parametrizables",
                                            "Sin saltos entre plataformas de productos o herramientas de ingeniería.",
                                            "Máquinas energéticamente eficientes gracias a fuentes de alimentación regenerativas y de entrada",
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // borde interno azul pro
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(32 * s),
                                        border: Border.all(
                                          color: const Color(0xFF59D7FF)
                                              .withOpacity(0.55),
                                          width: 2.2,
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

// ===================== HEADLINE =====================

class _TopHeadline extends StatelessWidget {
  final double s;
  final String title;
  const _TopHeadline({required this.s, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22 * s, vertical: 14 * s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * s),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                blurRadius: 26 * s,
                offset: Offset(0, 12 * s),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 10 * s,
                height: 34 * s,
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
              SizedBox(width: 14 * s),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 56 * s,
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


// ===================== BULLET COLUMN =====================

class _BulletColumn extends StatelessWidget {
  final double s;
  final String title;
  final List<String> bullets;

  const _BulletColumn({
    required this.s,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(22 * s),
            border: Border.all(
              color: Colors.white.withOpacity(0.10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22 * s,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
              ),
              SizedBox(height: 10 * s),

              // bullets
              Expanded(
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bullets.length,
                  separatorBuilder: (_, __) => SizedBox(height: 10 * s),
                  itemBuilder: (_, i) => _BulletLine(s: s, text: bullets[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final double s;
  final String text;

  const _BulletLine({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6 * s),
          child: Container(
            width: 6.5 * s,
            height: 6.5 * s,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.90),
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
              fontSize: 16 * s,
              height: 1.25,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.90),
            ),
          ),
        ),
      ],
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
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.35),
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

// ===================== FIT IMAGE TO CARD =====================
// Truco: blur cover atrás + contain adelante.
// topInset/sideInset/bottomInset te dan aire contra esquinas redondas.
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
              opacity: 0.55,
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
          child: Container(color: Colors.black.withOpacity(0.10)),
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

// ===================== FALLBACK IMAGE =====================

class _ImageFallback extends StatelessWidget {
  final double s;
  final String label;
  const _ImageFallback({required this.s, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.image_rounded,
                size: 56 * s, color: Colors.white.withOpacity(0.70)),
            SizedBox(height: 10 * s),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5 * s,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.78),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== WATERMARK =====================

class _WatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = Colors.white.withOpacity(0.18);

    // 3 círculos grandes tipo watermark (izq / centro / der)
    final r = size.height * 0.42;
    canvas.drawCircle(Offset(size.width * 0.17, size.height * 0.62), r, p);
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.60), r, p);
    canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.62), r, p);

    // un aro interno más fino
    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = Colors.white.withOpacity(0.14);
    canvas.drawCircle(Offset(size.width * 0.17, size.height * 0.62), r * 0.72, p2);
    canvas.drawCircle(Offset(size.width * 0.50, size.height * 0.60), r * 0.72, p2);
    canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.62), r * 0.72, p2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
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
