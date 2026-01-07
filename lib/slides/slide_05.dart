import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide05 extends StatefulWidget {
  const Slide05({super.key});

  @override
  State<Slide05> createState() => _Slide05State();
}

class _Slide05State extends State<Slide05> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );
    _scale = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.10, 1.0, curve: Curves.easeOutBack),
      ),
    );
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.10, 0.70, curve: Curves.easeOutCubic),
          ),
        );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.25);
        final footerSpace = 128.0 * s;

        return AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo con imagen =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // 👈 cámbialo si tu fondo slide5 es otro
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay pro (oscurece + viñeta) =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.58),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0.0, -0.1),
                        radius: 1.15,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.45),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Texto central =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: footerSpace),
                    child: Center(
                      child: FadeTransition(
                        opacity: _fade,
                        child: SlideTransition(
                          position: _slideUp,
                          child: ScaleTransition(
                            scale: _scale,
                            child: _BigTitle(scale: s),
                          ),
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
            );
          },
        );
      },
    );
  }
}

class _BigTitle extends StatelessWidget {
  final double scale;
  const _BigTitle({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 44 * scale,
        vertical: 26 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26 * scale),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30 * scale,
            offset: Offset(0, 14 * scale),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SOLUCIÓN',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 92 * scale,
              fontWeight: FontWeight.w900,
              color: Colors.white.withValues(alpha: 0.90),
              letterSpacing: 1.6 * scale,
              height: 1.0,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'COMPLETA',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 92 * scale,
              fontWeight: FontWeight.w900,
              color: Colors.white.withValues(alpha: 0.90),
              letterSpacing: 1.6 * scale,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
