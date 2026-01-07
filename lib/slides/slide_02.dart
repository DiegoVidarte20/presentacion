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

    _slideTitle = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle _t(double s, double size,
      {FontWeight fw = FontWeight.w600, Color col = Colors.white}) {
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

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo con imagen =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // <-- cambia ruta
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay para legibilidad =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.60),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Contenido =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(60 * s, 42 * s, 60 * s, 120 * s),
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: SlideTransition(
                        position: _slideTitle,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'OBJETIVO',
                              style: _t(s, 46, fw: FontWeight.w700)
                                  .copyWith(letterSpacing: 1.2),
                            ),
                            SizedBox(height: 10 * s),
                            Container(
                              width: 520 * s,
                              height: 2 * s,
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                            SizedBox(height: 26 * s),

                            // Bloque de texto base
                            Text(
                              '• Integrar ctrlX CORE con los dispositivos de campo.\n'
                              '• Estandarizar comunicación y monitoreo.\n'
                              '• Preparar base para escalamiento y analítica.',
                              style: _t(
                                s,
                                26,
                                fw: FontWeight.w400,
                                col: Colors.white.withValues(alpha: 0.92),
                              ).copyWith(height: 1.45),
                            ),

                            const Spacer(),

                            // Tarjetita simple (placeholder)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 520 * s,
                                padding: EdgeInsets.all(18 * s),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16 * s),
                                  color: Colors.white.withValues(alpha: 0.08),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.14),
                                  ),
                                ),
                                child: Text(
                                  'Placeholder de contenido\n(puedes meter una imagen, diagrama o bullets)',
                                  style: _t(
                                    s,
                                    16,
                                    fw: FontWeight.w500,
                                    col: Colors.white.withValues(alpha: 0.80),
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
