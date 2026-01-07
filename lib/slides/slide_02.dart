import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide02 extends StatefulWidget {
  const Slide02({super.key});

  @override
  State<Slide02> createState() => _Slide02State();
}

class _Slide02State extends State<Slide02> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideTitle;
  late final Animation<double> _cardsIn;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _slideTitle = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.05, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _cardsIn = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.20, 1.0, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle _t(
    double s,
    double size, {
    FontWeight fw = FontWeight.w600,
    Color col = Colors.white,
  }) {
    return TextStyle(
      fontSize: size * s,
      fontWeight: fw,
      color: col,
      height: 1.1,
      letterSpacing: 0.4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.25);

        // 👇 Ajusta tamaños si quieres
        final cardSize = 340.0 * s; // cuadrado blanco
        final cardGap = 80.0 * s; // separación entre cards
        final borderW = 3.0 * s;
        final borderCol = const Color(0xFF2EC4FF);

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo con imagen =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // <-- pon tu fondo del slide2 si tienes
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay (azul izq + rojo der + oscurecer) =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF0086C9).withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.35),
                          const Color(0xFFFF2B2B).withValues(alpha: 0.22),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: 0.20)),
                ),

                // ===== Títulos arriba izquierda =====
                Positioned(
                  left: 52 * s,
                  top: 42 * s,
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: SlideTransition(
                      position: _slideTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CTRL X CORE',
                            style: _t(
                              s,
                              30,
                              fw: FontWeight.w500,
                            ).copyWith(letterSpacing: 1.2),
                          ),
                          SizedBox(height: 18 * s),
                          Text(
                            'CTRL X CORE - Ventajas',
                            style: _t(s, 34, fw: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== 3 imágenes centradas =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 90 * s,
                      right: 90 * s,
                      top: 170 * s,
                      bottom: 140 * s, // deja espacio al footer
                    ),
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.96,
                          end: 1.0,
                        ).animate(_cardsIn),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _IconCard(
                              size: cardSize,
                              borderW: borderW,
                              borderCol: borderCol,
                              // ✅ cambia a tu asset real
                              imagePath: 'assets/slide2/icono1.jpeg',
                            ),
                            SizedBox(width: cardGap),
                            _IconCard(
                              size: cardSize,
                              borderW: borderW,
                              borderCol: borderCol,
                              imagePath: 'assets/slide2/icono2.jpeg',
                            ),
                            SizedBox(width: cardGap),
                            _IconCard(
                              size: cardSize,
                              borderW: borderW,
                              borderCol: borderCol,
                              imagePath: 'assets/slide2/icono3.jpeg',
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
                    opacity: _fadeIn,
                    child: FooterBand(scale: s),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _IconCard extends StatelessWidget {
  final double size;
  final double borderW;
  final Color borderCol;
  final String imagePath;

  const _IconCard({
    required this.size,
    required this.borderW,
    required this.borderCol,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderCol, width: borderW),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.10),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
