// lib/slides/slide_10.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide10 extends StatefulWidget {
  const Slide10({super.key});

  @override
  State<Slide10> createState() => _Slide10State();
}

class _Slide10State extends State<Slide10> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rightIn;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero)
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
            curve: const Interval(0.10, 0.75, curve: Curves.easeOutCubic),
          ),
        );

    _rightIn = Tween<Offset>(begin: const Offset(0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.18, 0.90, curve: Curves.easeOutCubic),
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

    // ✅ CAMBIA ESTO por tu asset real (ya lo tienes en assets)
    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              // ✅ más aire: arriba y abajo
              padding: EdgeInsets.fromLTRB(34 * s, 24 * s, 34 * s, 118 * s),
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: _titleIn,
                      child: _HeaderBar(
                        s: s,
                        title: "CtrlX I/O – Periferias",
                        chip: "Slide 10",
                      ),
                    ),

                    // ✅ separa el header del contenido principal
                    SizedBox(height: 28 * s),

                    Expanded(
                      child: Padding(
                        // ✅ aire interno extra para que no quede pegado ni arriba ni abajo
                        padding: EdgeInsets.symmetric(vertical: 10 * s),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ===== LEFT: 2 bullet cards =====
                            Expanded(
                              flex: 33,
                              child: SlideTransition(
                                position: _leftIn,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: _BulletCard(
                                        s: s,
                                        icon: Icons.extension_rounded,
                                        title: "Arquitectura modular",
                                        bullets: const [
                                          "La gama de E/S se ha diseñado para integrarse horizontal y verticalmente y representa una extensión funcional de la plataforma de control ctrlX CORE.",
                                          "La configuración es compacta, modular y robusta, lo que permite ahorrar mucho espacio.",
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16 * s),
                                    Expanded(
                                      child: _BulletCard(
                                        s: s,
                                        icon: Icons.hub_rounded,
                                        title: "Ecosistema y futuro",
                                        bullets: const [
                                          "La solución flexible y potente ofrece, entre otras cosas, apertura para el ecosistema de EtherCAT.",
                                          "Módulos E/S orientados a las futuras tecnologías como 5G, TSN e IA.",
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(width: 20 * s),

                            // ===== RIGHT: image placeholder =====
                            Expanded(
                              flex: 67,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _ImageSlotCard(
                                  s: s,
                                  image: null,
                                  hint: "ESPACIO PARA TU IMAGEN",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ===== Footer reutilizable =====
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

// ===================== BACKGROUND IMAGE =====================

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

        // overlay oscuro para que el texto se lea bonito
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF061427).withOpacity(0.65),
                  const Color(0xFF020612).withOpacity(0.55),
                ],
              ),
            ),
          ),
        ),

        // grid sutil (opcional, como tu estilo)
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

// ===================== HEADER =====================

class _HeaderBar extends StatelessWidget {
  final double s;
  final String title;
  final String chip;
  const _HeaderBar({required this.s, required this.title, required this.chip});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 14 * s),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF0B2B55).withOpacity(0.92),
                const Color(0xFF0A3D7A).withOpacity(0.72),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                offset: const Offset(0, 12),
                color: Colors.black.withOpacity(0.35),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 10 * s,
                height: 30 * s,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF59D7FF).withOpacity(0.95),
                      const Color(0xFF2B6CFF).withOpacity(0.95),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                    fontSize: 34 * s,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12 * s),
              _ChipPill(s: s, text: chip),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChipPill extends StatelessWidget {
  final double s;
  final String text;
  const _ChipPill({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 7 * s),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5 * s,
          color: Colors.white.withOpacity(0.92),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ===================== LEFT BULLET CARDS =====================

class _BulletCard extends StatelessWidget {
  final double s;
  final IconData icon;
  final String title;
  final List<String> bullets;

  const _BulletCard({
    required this.s,
    required this.icon,
    required this.title,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.all(18 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(26 * s),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.42),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                offset: const Offset(0, 12),
                color: Colors.black.withOpacity(0.30),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44 * s,
                    height: 44 * s,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14 * s),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF59D7FF).withOpacity(0.95),
                          const Color(0xFF2B6CFF).withOpacity(0.95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                          color: const Color(0xFF2B6CFF).withOpacity(0.22),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 22 * s),
                  ),
                  SizedBox(width: 12 * s),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.5 * s,
                        height: 1.08,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * s),
              Expanded(
                child: _BulletList(s: s, items: bullets),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final double s;
  final List<String> items;
  const _BulletList({required this.s, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: (i == items.length - 1) ? 0 : 10 * s,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "•",
                style: TextStyle(
                  fontSize: 18 * s,
                  height: 1.25,
                  color: Colors.white.withOpacity(0.95),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 10 * s),
              Expanded(
                child: Text(
                  items[i],
                  style: TextStyle(
                    fontSize: 13.4 * s,
                    height: 1.35,
                    color: Colors.white.withOpacity(0.90),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

// ===================== RIGHT IMAGE SLOT =====================

class _ImageSlotCard extends StatelessWidget {
  final double s;
  final Widget? image; // pasa Image.asset(...) cuando lo tengas
  final String hint;

  const _ImageSlotCard({
    required this.s,
    required this.image,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(28 * s),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.55),
              width: 2.0,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 26,
                offset: const Offset(0, 14),
                color: Colors.black.withOpacity(0.32),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26 * s),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.white.withOpacity(0.03)),
                ),

                // Si hay imagen -> la mostramos
                if (image != null)
                  Positioned.fill(child: image!)
                else
                  // Placeholder elegante
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 46 * s,
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

                // shine top
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 80 * s,
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
