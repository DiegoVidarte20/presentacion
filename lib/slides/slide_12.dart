// lib/slides/slide_12.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide12 extends StatefulWidget {
  const Slide12({super.key});

  @override
  State<Slide12> createState() => _Slide12State();
}

class _Slide12State extends State<Slide12> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rtIn;
  late final Animation<Offset> _rbIn;

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

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _leftIn = Tween<Offset>(begin: const Offset(-0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.12, 0.92, curve: Curves.easeOutCubic),
          ),
        );

    _rtIn = Tween<Offset>(begin: const Offset(0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.18, 0.95, curve: Curves.easeOutCubic),
          ),
        );

    _rbIn = Tween<Offset>(begin: const Offset(0.10, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.24, 1.00, curve: Curves.easeOutCubic),
          ),
        );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _scale(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w / 1366.0).clamp(0.85, 1.15);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scale(context);

    // ✅ fondo general
    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    // ✅ tus 2 imágenes del slide 12 (cámbialas a tus assets reales)
    const leftDiagram = "assets/slide12/slide12_1.jpg";
    const rightShot = "assets/slide12/slide12_2.jpg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              // 👇 aire arriba / abajo para no pegarse al footer
              padding: EdgeInsets.fromLTRB(28 * s, 26 * s, 28 * s, 128 * s),
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: _titleIn,
                      child: _GlassTitlePill(
                        s: s,
                        title: "EtherCAT – Perfiles",
                      ),
                    ),
                    SizedBox(height: 20 * s),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ================= LEFT: 2 IMÁGENES =================
                          Expanded(
                            flex: 62,
                            child: SlideTransition(
                              position: _leftIn,
                              child: Column(
                                children: [
                                  // ---- top image ----
                                  Expanded(
                                    flex: 52,
                                    child: _GlassCard(
                                      s: s,
                                      radius: 28,
                                      padding: EdgeInsets.zero,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          28 * s,
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Image.asset(
                                                leftDiagram,
                                                fit: BoxFit.cover,
                                                alignment: Alignment.center,
                                                errorBuilder: (_, __, ___) =>
                                                    _ImageFallback(
                                                      s: s,
                                                      label:
                                                          "IMAGEN 1\nTopologías EtherCAT",
                                                    ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 16 * s,
                                              right: 16 * s,
                                              bottom: 16 * s,
                                              child: _CaptionPill(
                                                s: s,
                                                icon:
                                                    Icons.account_tree_rounded,
                                                text:
                                                    "Topologías y Junction Slave",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 16 * s),

                                  // ---- bottom image ----
                                  Expanded(
                                    flex: 48,
                                    child: SlideTransition(
                                      position: _rtIn,
                                      child: _GlassCard(
                                        s: s,
                                        radius: 28,
                                        padding: EdgeInsets.zero,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            28 * s,
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Image.asset(
                                                  rightShot,
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  errorBuilder: (_, __, ___) =>
                                                      _ImageFallback(
                                                        s: s,
                                                        label:
                                                            "IMAGEN 2\nConfiguración / Tool",
                                                      ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 16 * s,
                                                right: 16 * s,
                                                bottom: 16 * s,
                                                child: _CaptionPill(
                                                  s: s,
                                                  icon: Icons.build_rounded,
                                                  text:
                                                      "Configuración EtherCAT (IDE / CtrlX)",
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

                          SizedBox(width: 18 * s),

                          // ================= RIGHT: TABLA GRANDE =================
                          Expanded(
                            flex: 38,
                            child: SlideTransition(
                              position: _rbIn,
                              child: _GlassCard(
                                s: s,
                                radius: 28,
                                padding: EdgeInsets.fromLTRB(
                                  16 * s,
                                  14 * s,
                                  16 * s,
                                  14 * s,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40 * s,
                                          height: 40 * s,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              14 * s,
                                            ),
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(
                                                  0xFF59D7FF,
                                                ).withOpacity(0.95),
                                                const Color(
                                                  0xFF2B6CFF,
                                                ).withOpacity(0.90),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 14,
                                                offset: const Offset(0, 8),
                                                color: const Color(
                                                  0xFF2B6CFF,
                                                ).withOpacity(0.20),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.view_list_rounded,
                                            color: Colors.white,
                                            size: 22 * s,
                                          ),
                                        ),
                                        SizedBox(width: 12 * s),
                                        Expanded(
                                          child: Text(
                                            "Perfiles y prioridad de comunicación",
                                            style: TextStyle(
                                              fontSize: 16.5 * s,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white.withOpacity(
                                                0.95,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12 * s),
                                    Expanded(child: _ProfilesTable(s: s)),
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

// ===================== TITLE =====================

class _GlassTitlePill extends StatelessWidget {
  final double s;
  final String title;

  const _GlassTitlePill({required this.s, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22 * s, vertical: 18 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(26 * s),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, 16),
                color: Colors.black.withOpacity(0.35),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 10 * s,
                height: 44 * s,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF59D7FF).withOpacity(0.95),
                      const Color(0xFF2B6CFF).withOpacity(0.95),
                      const Color(0xFFFF3D5A).withOpacity(0.55),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              SizedBox(width: 16 * s),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 40 * s,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                    color: Colors.white,
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
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.35),
              width: 1.6,
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

// ===================== CAPTION =====================

class _CaptionPill extends StatelessWidget {
  final double s;
  final IconData icon;
  final String text;

  const _CaptionPill({required this.s, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14 * s, vertical: 10 * s),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.26),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18 * s, color: Colors.white.withOpacity(0.92)),
              SizedBox(width: 10 * s),
              Text(
                text,
                style: TextStyle(
                  fontSize: 12.8 * s,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.92),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== TABLE =====================

class _ProfilesTable extends StatelessWidget {
  final double s;
  const _ProfilesTable({required this.s});

  TextStyle get _h => TextStyle(
    fontSize: 12.8 * s,
    fontWeight: FontWeight.w900,
    color: Colors.white.withOpacity(0.95),
  );

  TextStyle get _b => TextStyle(
    fontSize: 12.6 * s,
    fontWeight: FontWeight.w600,
    height: 1.25,
    color: Colors.white.withOpacity(0.88),
  );

  TableRow _gap(double h) => TableRow(
  children: List.generate(
    4,
    (_) => SizedBox(height: h),
  ),
);


  TableRow _row({
    required String proto,
    required String meaning,
    required String device,
    required String prio,
    bool header = false,
  }) {
    final pad = EdgeInsets.symmetric(horizontal: 12 * s, vertical: 16 * s);

    Widget cell(String t, TextStyle st, {FontWeight? fw}) => Padding(
      padding: pad,
      child: Text(t, style: st.copyWith(fontWeight: fw ?? st.fontWeight)),
    );

    return TableRow(
      decoration: BoxDecoration(
        color: header
            ? Colors.white.withOpacity(0.10)
            : Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14 * s),
      ),
      children: [
        cell(
          proto,
          header ? _h : _b,
          fw: header ? FontWeight.w900 : FontWeight.w800,
        ),
        cell(meaning, header ? _h : _b),
        cell(device, header ? _h : _b),
        cell(prio, header ? _h : _b),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18 * s),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.95),
          1: FlexColumnWidth(1.45),
          2: FlexColumnWidth(1.60),
          3: FlexColumnWidth(1.10),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _row(
            proto: "Protocolo",
            meaning: "Significado",
            device: "Tipo de dispositivo",
            prio: "Prioridad",
            header: true,
          ),
          _gap(10 * s),

          _row(
            proto: "CoE",
            meaning: "CANopen over\nEtherCAT",
            device: "Sensores, E/S,\nactuadores generales",
            prio: "Media\n(Cíclica)",
          ),
          _gap(10 * s),

          _row(
            proto: "SoE",
            meaning: "SERCOS over\nEtherCAT",
            device: "Servo drives\n(ctrlX DRIVE)",
            prio: "Alta\n(Tiempo real)",
          ),
          _gap(10 * s),

          _row(
            proto: "FSoE",
            meaning: "FailSafe over\nEtherCAT",
            device: "Dispositivos de\nseguridad (SAFEX)",
            prio: "Crítica\n(Seguridad)",
          ),
        ],
      ),
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
            Icon(
              Icons.image_rounded,
              size: 56 * s,
              color: Colors.white.withOpacity(0.70),
            ),
            SizedBox(height: 10 * s),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5 * s,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ],
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF061427).withOpacity(0.62),
                  const Color(0xFF020612).withOpacity(0.55),
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
