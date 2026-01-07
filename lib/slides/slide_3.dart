import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide03 extends StatefulWidget {
  const Slide03({super.key});

  @override
  State<Slide03> createState() => _Slide03State();
}

class _Slide03State extends State<Slide03> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<double> _contentIn;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.05, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    _contentIn = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.20, 1.0, curve: Curves.easeOutBack),
    );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  TextStyle _t(
    double s,
    double size, {
    FontWeight fw = FontWeight.w600,
    Color col = Colors.white,
    double lh = 1.15,
    double ls = 0.2,
  }) {
    return TextStyle(
      fontSize: size * s,
      fontWeight: fw,
      color: col,
      height: lh,
      letterSpacing: ls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.25);

        final padX = 64.0 * s;
        final footerSpace = 128.0 * s;

        return AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo con imagen =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // ✅ cámbialo a tu fondo slide3 si es otro
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay cinematic (azul -> transparente -> rojo) =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF2EC4FF).withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.25),
                          const Color(0xFFFF2B2B).withValues(alpha: 0.14),
                        ],
                      ),
                    ),
                  ),
                ),
                // Sombra vertical para legibilidad general
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.40),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Header glass (no barra plana) =====
                Positioned(
                  left: padX,
                  right: padX,
                  top: 34 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _titleIn,
                      child: _GlassHeader(
                        scale: s,
                        title: 'Un Nuevo Mundo de Automatización',
                      ),
                    ),
                  ),
                ),

                // ===== Contenido =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      padX,
                      150 * s,
                      padX,
                      footerSpace,
                    ),
                    child: FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.98,
                          end: 1.0,
                        ).animate(_contentIn),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Columna izquierda (texto + bullets)
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _GlassCard(
                                    scale: s,
                                    child: Text(
                                      'El mundo de la producción está cambiando. '
                                      'Los sistemas de automatización rígidos y complejos '
                                      'ya no son adecuados para mercados con ciclos de vida '
                                      'de producto cada vez más cortos y competencia más intensa.',
                                      style: _t(
                                        s,
                                        22,
                                        fw: FontWeight.w500,
                                        col: Colors.white.withValues(
                                          alpha: 0.92,
                                        ),
                                        lh: 1.55,
                                        ls: 0.2,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 18 * s),

                                  // Callout central estilo "pill" moderno
                                  _CalloutPill(scale: s),

                                  SizedBox(height: 22 * s),

                                  // Bullets con icono pro
                                  _Bullet(
                                    scale: s,
                                    title: 'Flexibilidad total',
                                    subtitle: '',
                                  ),
                                  SizedBox(height: 12 * s),
                                  _Bullet(
                                    scale: s,
                                    title: 'Reacción dinámica',
                                    subtitle: '',
                                  ),
                                  SizedBox(height: 12 * s),
                                  _Bullet(
                                    scale: s,
                                    title: 'Máxima apertura',
                                    subtitle:
                                        'En todos los niveles e interfaces',
                                  ),
                                ],
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
            );
          },
        );
      },
    );
  }
}

class _GlassHeader extends StatelessWidget {
  final double scale;
  final String title;

  const _GlassHeader({required this.scale, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 26 * scale,
        vertical: 18 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        color: Colors.white.withValues(alpha: 0.10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 22 * scale,
            offset: Offset(0, 10 * scale),
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
                  const Color(0xFF2EC4FF).withValues(alpha: 0.95),
                  const Color(0xFFFF2B2B).withValues(alpha: 0.85),
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
                fontSize: 46 * scale,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final double scale;
  final Widget child;

  const _GlassCard({required this.scale, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: child,
    );
  }
}

class _CalloutPill extends StatelessWidget {
  final double scale;

  const _CalloutPill({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 22 * scale,
        vertical: 18 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * scale),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF2EC4FF).withValues(alpha: 0.92),
            const Color(0xFF0B3C6E).withValues(alpha: 0.92),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'La respuesta a los nuevos desafíos:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30 * scale,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            'ctrlX AUTOMATION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34 * scale,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final double scale;
  final String title;
  final String subtitle;

  const _Bullet({
    required this.scale,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 26 * scale,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );
    final subStyle = TextStyle(
      fontSize: 20 * scale,
      fontWeight: FontWeight.w500,
      color: Colors.white.withValues(alpha: 0.84),
      height: 1.25,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // icon “check” pro (sin paquetes)
        Container(
          width: 28 * scale,
          height: 28 * scale,
          margin: EdgeInsets.only(top: 4 * scale),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.10),
            border: Border.all(
              color: const Color(0xFF2EC4FF).withValues(alpha: 0.55),
            ),
          ),
          child: Center(
            child: Icon(
              Icons.check,
              size: 18 * scale,
              color: const Color(0xFF2EC4FF),
            ),
          ),
        ),
        SizedBox(width: 14 * scale),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$title', style: titleStyle),
                if (subtitle.trim().isNotEmpty) ...[
                  TextSpan(text: ': ', style: titleStyle),
                  TextSpan(text: subtitle, style: subStyle),
                ] else
                  const TextSpan(text: ''),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

