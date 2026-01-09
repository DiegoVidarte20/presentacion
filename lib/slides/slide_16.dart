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
    // ✅ 4 imágenes (una por cada item)
    const topAssets = [
      "assets/slide16/slide16_1.png",
      "assets/slide16/slide16_2.png",
      "assets/slide16/slide16_3.png",
      "assets/slide16/slide16_4.png",
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
                          title: "Drives and Motors",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      // ===== TOP STRIP (glass) =====
                      SlideTransition(
                        position: _topCardIn,
                        child: SizedBox(
                          height: 250 * s,
                          child: _GlassCard(
                            s: s,
                            radius: 30,
                            padding: EdgeInsets.zero,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30 * s),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: _Top4ImagesWithLabels(
                                      s: s,
                                      assets: topAssets,
                                      labels: const [
                                        "MS2N Motors\n(Standard)",
                                        "MS2S Motors\n(Economics)",
                                        "Kit Motors",
                                        "Linear Motors",
                                      ],
                                    ),
                                  ),
                                  // borde interno pro (suave, no tan “marcador”)
                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30 * s,
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.14),
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

                      SizedBox(height: 14 * s),

                      // ===== BOTTOM PANEL (glass + texto blanco) =====
                      Expanded(
                        child: SlideTransition(
                          position: _bottomCardIn,
                          child: _GlassCard(
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
                                        opacity: 0.14,
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
                                        child: _InnerGlassPanel(
                                          s: s,
                                          child: _TextColumnCard(
                                            s: s,
                                            title:
                                                "Potente para mayor rendimiento",
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
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _InnerGlassPanel(
                                          s: s,
                                          child: _TextColumnCard(
                                            s: s,
                                            title:
                                                "Valor Añadido con CtrlX Drive",
                                            bullets: const [
                                              "Gemelo digital, mismo modelo dinámico de temperatura para uso seguro hasta los límites operativos",
                                              "Memoria de datos del motor con datos reales permite usar el motor como sensor de par simple sin componentes adicionales",
                                              "Memoria de datos de encoder ampliada para una puesta en marcha más rápida con datos adicionales para ejes mecatrónicos",
                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 14 * s),

                                      Expanded(
                                        child: _InnerGlassPanel(
                                          s: s,
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
                                      ),
                                    ],
                                  ),

                                  Positioned.fill(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          30 * s,
                                        ),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.14),
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
                    fontSize: 54 * scale,
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

// ===================== TOP STRIP (4 slices + labels) =====================

// ===================== TOP (4 imágenes separadas + labels) =====================

class _Top4ImagesWithLabels extends StatelessWidget {
  final double s;
  final List<String> assets; // 4 rutas
  final List<String> labels; // 4 textos

  const _Top4ImagesWithLabels({
    required this.s,
    required this.assets,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final n = assets.length; // 4
    final labelH = 56.0 * s;

    return Stack(
      children: [
        // fondo suave para mantener vibe
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF2EC4FF).withOpacity(0.08),
                  Colors.black.withOpacity(0.10),
                  const Color(0xFFFF2B2B).withOpacity(0.06),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(22 * s, 16 * s, 22 * s, 14 * s),
          child: Column(
            children: [
              // ===== fila de 4 imágenes =====
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(n, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18 * s),
                        child: _GlassImageTile(
                          s: s,
                          asset: assets[i],
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: 10 * s),

              // ===== fila de labels (debajo de cada imagen) =====
              SizedBox(
                height: labelH,
                child: Row(
                  children: List.generate(n, (i) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10 * s),
                        child: _TitlePill(s: s, text: labels[i]),
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

class _GlassImageTile extends StatelessWidget {
  final double s;
  final String asset;

  const _GlassImageTile({
    required this.s,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => Container(
          color: Colors.white.withOpacity(0.05),
          child: Center(
            child: Icon(Icons.image_rounded,
                size: 42 * s, color: Colors.white.withOpacity(0.70)),
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16 * s),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.2),
          ),
          child: Stack(
            children: [
              // blur cover atrás (con la misma imagen)
              Positioned.fill(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
                  child: Opacity(
                    opacity: 0.45,
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
                child: Container(color: Colors.black.withOpacity(0.08)),
              ),
              // imagen adelante (contain para que se vea el producto grande y limpio)
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(10 * s),
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
          ),
        ),
      ),
    );
  }
}


// ===================== TITLE PILL (glass) =====================

class _TitlePill extends StatelessWidget {
  final double s;
  final String text;
  const _TitlePill({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    final radius = 18 * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 10 * s),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(
              color: Colors.white.withOpacity(0.14),
              width: 1.2,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFF2EC4FF).withOpacity(0.22),
                        Colors.white.withOpacity(0.06),
                        const Color(0xFFFF2B2B).withOpacity(0.16),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.5 * s,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.95),
                    letterSpacing: 0.1,
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

// ===================== INNER GLASS (para columnas) =====================

class _InnerGlassPanel extends StatelessWidget {
  final double s;
  final Widget child;
  const _InnerGlassPanel({required this.s, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.fromLTRB(12 * s, 12 * s, 12 * s, 12 * s),
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

// ===================== BOTTOM COLUMNS (texto blanco) =====================

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
      padding: EdgeInsets.fromLTRB(6 * s, 4 * s, 6 * s, 4 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24.5 * s,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.96),
            ),
          ),
          SizedBox(height: 10 * s),
          ...bullets.map((t) => _BulletLineLight(s: s, text: t)),
          if (subTitle != null) ...[
            SizedBox(height: 14 * s),
            Text(
              subTitle!,
              style: TextStyle(
                fontSize: 22.5 * s,
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.96),
              ),
            ),
          ],
          if (subBullets != null) ...[
            SizedBox(height: 10 * s),
            ...subBullets!.map((t) => _BulletLineLight(s: s, text: t)),
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
      padding: EdgeInsets.fromLTRB(6 * s, 4 * s, 6 * s, 4 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.5 * s,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.96),
            ),
          ),
          Text(
            accent,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.5 * s,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF2EC4FF).withOpacity(0.95),
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
                  fontSize: 17.5 * s,
                  height: 1.22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.90),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletLineLight extends StatelessWidget {
  final double s;
  final String text;
  const _BulletLineLight({required this.s, required this.text});

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
              width: 7 * s,
              height: 7 * s,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2EC4FF).withOpacity(0.80),
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
                fontSize: 17.0 * s,
                height: 1.22,
                fontWeight: FontWeight.w700,
                color: Colors.white.withOpacity(0.90),
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

// ===================== WATERMARK =====================

class _SoftRingWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.white.withOpacity(0.16);

    final r = size.height * 0.42;
    canvas.drawCircle(Offset(size.width * 0.20, size.height * 0.62), r, p);
    canvas.drawCircle(Offset(size.width * 0.52, size.height * 0.60), r, p);
    canvas.drawCircle(Offset(size.width * 0.83, size.height * 0.62), r, p);

    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = Colors.white.withOpacity(0.12);

    canvas.drawCircle(
      Offset(size.width * 0.20, size.height * 0.62),
      r * 0.72,
      p2,
    );
    canvas.drawCircle(
      Offset(size.width * 0.52, size.height * 0.60),
      r * 0.72,
      p2,
    );
    canvas.drawCircle(
      Offset(size.width * 0.83, size.height * 0.62),
      r * 0.72,
      p2,
    );
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

        // overlay cinematic (cyan/rojo)
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
