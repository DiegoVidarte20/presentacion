// lib/slides/slide_11.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide11 extends StatefulWidget {
  const Slide11({super.key});

  @override
  State<Slide11> createState() => _Slide11State();
}

class _Slide11State extends State<Slide11> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _midIn;
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
            curve: const Interval(0.12, 0.90, curve: Curves.easeOutCubic),
          ),
        );

    // ✅ ESTE ERA EL QUE FALTABA
    _midIn = Tween<Offset>(begin: const Offset(0.06, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.16, 0.95, curve: Curves.easeOutCubic),
          ),
        );

    _rightIn = Tween<Offset>(begin: const Offset(0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.20, 1.00, curve: Curves.easeOutCubic),
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

    // ✅ pon tu asset real
    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              // aire arriba y abajo para que NO se pegue al título ni al footer
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
                        title: "EtherCAT and Gigabit Ethernet",
                      ),
                    ),
                    SizedBox(height: 20 * s),

                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ================= LEFT: 2 big cards =================
                          Expanded(
                            flex: 30,
                            child: SlideTransition(
                              position: _leftIn,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: _BigNumberCard(
                                      s: s,
                                      number: "1.",
                                      title:
                                          "Gigabit Ethernet: El bus de\nIT e Ingeniería",
                                      body:
                                          "Estos puertos están diseñados\n"
                                          "para mover grandes\n"
                                          "volúmenes de datos hacia\n"
                                          "afuera de la máquina.",
                                    ),
                                  ),
                                  SizedBox(height: 14 * s),
                                  Expanded(
                                    child: _BigNumberCard(
                                      s: s,
                                      number: "2.",
                                      title:
                                          "EtherCAT: El bus de\nautomatización (Tiempo Real)",
                                      body:
                                          "EtherCAT es el protocolo\n"
                                          "estándar que utiliza ctrlX para\n"
                                          "el control de movimiento y la\n"
                                          "periferia. Es el \"idioma\" que\n"
                                          "habla el PLC con los motores y\n"
                                          "sensores.",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 14 * s),

                          // ================= MID: 4 small info cards =================
                          Expanded(
                            flex: 26,
                            child: SlideTransition(
                              position: _midIn,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: _SmallInfoCard(
                                      s: s,
                                      rich: [
                                        _RichSeg.bold("Velocidad: "),
                                        _RichSeg.normal("Funciona a "),
                                        _RichSeg.bold("1000 Mbps\n(1 Gbps)"),
                                        _RichSeg.normal(
                                          ", es decir, 10 veces más\nrápido que EtherCAT en términos\nde ancho de banda puro.",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12 * s),
                                  Expanded(
                                    child: _SmallInfoCard(
                                      s: s,
                                      rich: [
                                        _RichSeg.bold("Función: "),
                                        _RichSeg.bold(
                                          "* Ingeniería:\nIIoT / Cloud: ",
                                        ),
                                        _RichSeg.normal(
                                          "Enviar datos a la nube\n",
                                        ),
                                        _RichSeg.bold("Comunicación IT: "),
                                        _RichSeg.normal(
                                          "Hablar con\ncámaras de visión artificial,\nservidores ERP o protocolos como\nOPC UA y MQTT.",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12 * s),
                                  Expanded(
                                    child: _SmallInfoCard(
                                      s: s,
                                      rich: [
                                        _RichSeg.bold("Velocidad: "),
                                        _RichSeg.normal("Funciona a "),
                                        _RichSeg.bold(
                                          "100 Mbps\nDeterministica",
                                        ),
                                        _RichSeg.normal(
                                          " (la capacidad de\ngarantizar que un mensaje llegue\nen el microsegundo exacto",
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 12 * s),
                                  Expanded(
                                    child: _SmallInfoCard(
                                      s: s,
                                      rich: [
                                        _RichSeg.bold("Ventaja: "),
                                        _RichSeg.normal(
                                          "Permite sincronizar más de\n200 ejes con una precisión casi\nperfecta, algo vital para la robótica\n(como integración con ",
                                        ),
                                        _RichSeg.bold("KUKA"),
                                        _RichSeg.normal(")"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 14 * s),

                          // ================= RIGHT: image slot =================
                          Expanded(
                            flex: 44,
                            child: SlideTransition(
                              position: _rightIn,
                              child: _ImageSlot(
                                s: s,
                                hint: "ESPACIO PARA TU IMAGEN",
                                // cuando quieras:
                                image: Image.asset("assets/slide11/slide11.png", fit: BoxFit.contain),
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

          // Footer reutilizable
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

// ===================== GLASS CARD SHELL (reusable) =====================

class _GlassCardShell extends StatelessWidget {
  final double s;
  final Widget child;
  final double radius;
  final Color accent;
  final EdgeInsetsGeometry padding;

  const _GlassCardShell({
    required this.s,
    required this.child,
    required this.accent,
    this.radius = 26,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final r = radius * s;
    final pad = EdgeInsetsGeometry.lerp(
      const EdgeInsets.all(16),
      padding,
      1.0,
    )!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: accent.withOpacity(0.30),
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
              // shine
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.12),
                        Colors.transparent,
                        Colors.black.withOpacity(0.10),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),

              // inner border (se ve pro)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    margin: EdgeInsets.all(1.2 * s),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular((radius * s) - 1.2 * s),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.10),
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),

              // content padding (AQUÍ el aire real)
              Padding(
                padding: pad,
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ===================== LEFT BIG CARDS (GLASS) =====================
class _BigNumberCard extends StatelessWidget {
  final double s;
  final String number;
  final String title;
  final String body;

  const _BigNumberCard({
    required this.s,
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF59D7FF);

    return _GlassCardShell(
      s: s,
      accent: accent,
      radius: 28,
      padding: EdgeInsets.fromLTRB(18 * s, 16 * s, 18 * s, 18 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11 * s, vertical: 7 * s),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: accent.withOpacity(0.55)),
                  color: Colors.white.withOpacity(0.08),
                ),
                child: Text(
                  number,
                  style: TextStyle(
                    fontSize: 14.5 * s,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withOpacity(0.95),
                  ),
                ),
              ),
              SizedBox(width: 12 * s),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 1 * s),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.8 * s,
                      height: 1.12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12 * s),

          // DIVIDER LINE (sutil)
          Container(
            height: 1,
            color: Colors.white.withOpacity(0.10),
          ),

          SizedBox(height: 12 * s),

          Expanded(
            child: Text(
              body,
              style: TextStyle(
                fontSize: 13.9 * s,
                height: 1.40,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.88),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ===================== MID SMALL CARDS (GLASS) =====================

class _SmallInfoCard extends StatelessWidget {
  final double s;
  final List<_RichSeg> rich;

  const _SmallInfoCard({required this.s, required this.rich});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF59D7FF);

    final base = TextStyle(
      fontSize: 13.4 * s,
      height: 1.30,
      fontWeight: FontWeight.w600,
      color: Colors.white.withOpacity(0.88),
    );

    return _GlassCardShell(
      s: s,
      accent: accent,
      radius: 22,
      padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
      child: ScrollConfiguration(
        behavior: const _NoGlowScroll(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: RichText(
            text: TextSpan(
              style: base,
              children: rich.map((seg) {
                return TextSpan(
                  text: seg.text,
                  style: seg.isBold
                      ? base.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withOpacity(0.95),
                        )
                      : base,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _NoGlowScroll extends ScrollBehavior {
  const _NoGlowScroll();
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}




class _RichSeg {
  final String text;
  final bool isBold;
  const _RichSeg._(this.text, this.isBold);

  static _RichSeg bold(String t) => _RichSeg._(t, true);
  static _RichSeg normal(String t) => _RichSeg._(t, false);
}

// ===================== RIGHT IMAGE SLOT =====================

class _ImageSlot extends StatelessWidget {
  final double s;
  final Widget? image;
  final String hint;

  const _ImageSlot({required this.s, required this.image, required this.hint});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(30 * s),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.45),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                offset: const Offset(0, 16),
                color: Colors.black.withOpacity(0.33),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28 * s),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.white.withOpacity(0.03)),
                ),
                if (image != null)
                  Positioned.fill(child: image!)
                else
                  Center(
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
                          hint,
                          style: TextStyle(
                            fontSize: 15 * s,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w800,
                            color: Colors.white.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 90 * s,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.10),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== BACKGROUND IMAGE + overlay =====================

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
