// lib/slides/slide_16.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide16 extends StatefulWidget {
  const Slide16({super.key});

  @override
  State<Slide16> createState() => _Slide16State();
}

class _Slide16State extends State<Slide16> with SingleTickerProviderStateMixin {
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

    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    // ✅ una sola tira (con las 4 imágenes arriba)
    const topStrip = "assets/slide16/slide16.jpeg";

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

                      // ===== TOP STRIP (4 items, 1 sola imagen) =====
                      SlideTransition(
                        position: _topCardIn,
                        child: SizedBox(
                          height: 250 * s,
                          child: _WhiteCard(
                            s: s,
                            radius: 30,
                            padding: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30 * s),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: _TopStrip4WithLabels(
                                      s: s,
                                      asset: topStrip,
                                      labels: const [
                                        "MS2N Motors\n(Standard)",
                                        "MS2S Motors\n(Economics)",
                                        "Kit Motors",
                                        "Linear Motors",
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30 * s),
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

                      SizedBox(height: 14 * s),

                      // ===== BOTTOM PANEL (3 columnas) =====
                      Expanded(
                        child: SlideTransition(
                          position: _bottomCardIn,
                          child: _WhiteCard(
                            s: s,
                            radius: 30,
                            padding: EdgeInsets.fromLTRB(
                              18 * s,
                              16 * s,
                              18 * s,
                              16 * s,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30 * s),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: IgnorePointer(
                                      child: Opacity(
                                        opacity: 0.22,
                                        child: CustomPaint(
                                          painter: _SoftRingWatermarkPainter(),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        child: _TextColumnCard(
                                          s: s,
                                          title: "Potente para mayor rendimiento",
                                          bullets: const [
                                            "7 tamaños con par máximo de 4...692 Nm",
                                            "Diseño compacto con un 30% más de densidad de par",
                                            "Máxima eficiencia energética",
                                          ],
                                          subTitle:
                                              "Configurable de Forma Flexible",
                                          subBullets: const [
                                            "Conexión robusta con solo cable hasta 75m",
                                            "Encoder con seguridad funcional hasta SIL3, sin componentes de seguridad adicionales",
                                            "Primera serie ATEX mundial con cable único",
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _TextColumnCard(
                                          s: s,
                                          title: "Valor Añadido con CtrlX Drive",
                                          bullets: const [
                                            "Gemelo digital, mismo modelo dinámico de temperatura para uso seguro hasta los límites operativos",
                                            "Memoria de datos del motor con datos reales permite usar el motor como sensor de par simple sin componentes adicionales",
                                            "Memoria de datos de encoder ampliada para una puesta en marcha más rápida con datos adicionales para ejes mecatrónicos",
                                          ],
                                        ),
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _RightColumnCard(
                                          s: s,
                                          title: "Motores de Accionamiento",
                                          accent: "Directo",
                                          lines: const [
                                            "Productividad máxima de movimientos lineales o rotativos",
                                            "Alta dinámica con calidad de control superior",
                                            "Simplificación del diseño de la máquina",
                                            "Menos componentes y desgaste para una mayor disponibilidad",
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30 * s),
                                        border: Border.all(
                                          color: const Color(0xFF59D7FF)
                                              .withOpacity(0.65),
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

// ===================== TOP HEADLINE =====================

class _TopHeadline extends StatelessWidget {
  final double s;
  final String title;
  const _TopHeadline({required this.s, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 54 * s,
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

// ===================== TOP STRIP (4 slices + labels) =====================

class _TopStrip4WithLabels extends StatelessWidget {
  final double s;
  final String asset;
  final List<String> labels;

  const _TopStrip4WithLabels({
    required this.s,
    required this.asset,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final n = labels.length; // 4
    final labelH = 56.0 * s;

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
            child: Opacity(
              opacity: 0.35,
              child: Image.asset(asset, fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned.fill(child: Container(color: Colors.white.withOpacity(0.86))),

        Padding(
          padding: EdgeInsets.fromLTRB(22 * s, 16 * s, 22 * s, 14 * s),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(n, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18 * s),
                        child: _StripSliceTile(
                          s: s,
                          asset: asset,
                          index: i,
                          count: n,
                          // subimos para ocultar el texto que viene “impreso” en la tira
                          cropShiftYFactor: 0.28,
                          // zoom para que el producto se vea grande
                          zoom: 1.18,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 10 * s),
              SizedBox(
                height: labelH,
                child: Row(
                  children: List.generate(n, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10 * s),
                        child: _MotorLabel(s: s, text: labels[i]),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),

        // bar azul delgada
        Positioned(
          left: 22 * s,
          right: 22 * s,
          bottom: 72 * s,
          child: Container(
            height: 3 * s,
            color: const Color(0xFF59D7FF).withOpacity(0.55),
          ),
        ),
      ],
    );
  }
}

/// Tile que muestra SOLO 1/4 de la tira (sin repetirse)
class _StripSliceTile extends StatelessWidget {
  final double s;
  final String asset;
  final int index;
  final int count;
  final double cropShiftYFactor; // 0.0..0.4 aprox
  final double zoom; // 1.0..1.4 aprox

  const _StripSliceTile({
    required this.s,
    required this.asset,
    required this.index,
    required this.count,
    this.cropShiftYFactor = 0.28,
    this.zoom = 1.18,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        final shiftY = -(h * cropShiftYFactor);

        return ClipRRect(
          borderRadius: BorderRadius.circular(16 * s),
          child: Container(
            color: Colors.transparent,
            child: ClipRect(
              child: Transform.translate(
                offset: Offset(-w * index, shiftY),
                child: Transform.scale(
                  scale: zoom,
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    width: w * count,
                    height: h * 1.35,
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MotorLabel extends StatelessWidget {
  final double s;
  final String text;
  const _MotorLabel({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    // Formato especial: subtexto entre paréntesis, y si dice Economics lo subrayamos
    final parts = text.split("\n");
    final line1 = parts.isNotEmpty ? parts[0] : text;
    final line2 = parts.length > 1 ? parts[1] : "";

    final isEconomics = line2.toLowerCase().contains("economics");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          line1,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 18 * s,
            height: 1.0,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0B1B2B).withOpacity(0.95),
          ),
        ),
        if (line2.isNotEmpty) SizedBox(height: 4 * s),
        if (line2.isNotEmpty)
          Text(
            line2,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16 * s,
              height: 1.0,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B1B2B).withOpacity(0.92),
              decoration:
                  isEconomics ? TextDecoration.underline : TextDecoration.none,
              decorationThickness: 2,
              decorationColor: const Color(0xFF59D7FF).withOpacity(0.95),
            ),
          ),
      ],
    );
  }
}

// ===================== BOTTOM COLUMNS =====================

class _TextColumnCard extends StatelessWidget {
  final double s;
  final String title;
  final List<String> bullets;

  final String? subTitle;
  final List<String>? subBullets;

  const _TextColumnCard({
    required this.s,
    required this.title,
    required this.bullets,
    this.subTitle,
    this.subBullets,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10 * s, 8 * s, 10 * s, 8 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 26 * s,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B1B2B).withOpacity(0.96),
            ),
          ),
          SizedBox(height: 10 * s),
          ...bullets.map((t) => _BulletLineDark(s: s, text: t)),
          if (subTitle != null) ...[
            SizedBox(height: 14 * s),
            Text(
              subTitle!,
              style: TextStyle(
                fontSize: 24 * s,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF0B1B2B).withOpacity(0.96),
              ),
            ),
          ],
          if (subBullets != null) ...[
            SizedBox(height: 10 * s),
            ...subBullets!.map((t) => _BulletLineDark(s: s, text: t)),
          ],
        ],
      ),
    );
  }
}

class _RightColumnCard extends StatelessWidget {
  final double s;
  final String title;
  final String accent;
  final List<String> lines;

  const _RightColumnCard({
    required this.s,
    required this.title,
    required this.accent,
    required this.lines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10 * s, 8 * s, 10 * s, 8 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26 * s,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B1B2B).withOpacity(0.96),
            ),
          ),
          Text(
            accent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26 * s,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0B1B2B).withOpacity(0.96),
            ),
          ),
          SizedBox(height: 12 * s),
          ...lines.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 8 * s),
              child: Text(
                t,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18 * s,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0B1B2B).withOpacity(0.92),
                ),
              ),
            ),
          ),
        ],
      ),
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
      padding: EdgeInsets.only(bottom: 8 * s),
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
                fontSize: 17.5 * s,
                height: 1.22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0B1B2B).withOpacity(0.92),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== WHITE CARD (tipo screenshot) =====================

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

// ===================== WATERMARK =====================

class _SoftRingWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = const Color(0xFF59D7FF).withOpacity(0.16);

    final r = size.height * 0.42;
    canvas.drawCircle(Offset(size.width * 0.20, size.height * 0.62), r, p);
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.60), r, p);
    canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.62), r, p);

    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = const Color(0xFF59D7FF).withOpacity(0.12);

    canvas.drawCircle(Offset(size.width * 0.20, size.height * 0.62), r * 0.72, p2);
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.60), r * 0.72, p2);
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
          child: Image.asset(asset, fit: BoxFit.cover, alignment: Alignment.center),
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
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.step != step;
}
