// lib/slides/slide_08.dart
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide08 extends StatefulWidget {
  const Slide08({super.key});

  @override
  State<Slide08> createState() => _Slide08State();
}

class _Slide08State extends State<Slide08> with SingleTickerProviderStateMixin {
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

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.05, 0.45, curve: Curves.easeOutCubic),
          ),
        );

    _contentIn = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.18, 1.0, curve: Curves.easeOutBack),
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
        final h = c.maxHeight;
        final s = (w / 1400).clamp(0.75, 1.25);

        final padX = 64.0 * s;
        final topHeader = 36.0 * s;
        final footerSpace = 116.0 * s;

        // ✅ Cambia a tu fondo real del slide 8
        final bg = 'assets/slide1/fondoslide1.jpeg';

        return AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo =====
                Positioned.fill(child: Image.asset(bg, fit: BoxFit.cover)),

                // ===== Overlay cinematic (cool) =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF2EC4FF).withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.30),
                          const Color(0xFFFF2B2B).withValues(alpha: 0.14),
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
                          Colors.black.withValues(alpha: 0.14),
                          Colors.black.withValues(alpha: 0.42),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Header glass =====
                Positioned(
                  left: padX,
                  right: padX,
                  top: topHeader,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _titleIn,
                      child: _HeaderGlass(
                        scale: s,
                        title: 'CtrlX Core - CPU',
                        subtitle:
                            'Arquitectura, sistema operativo y ecosistema',
                      ),
                    ),
                  ),
                ),

                // ===== Content =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      padX,
                      (topHeader + 126 * s), // aire bajo header
                      padX,
                      footerSpace,
                    ),
                    child: FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.985,
                          end: 1.0,
                        ).animate(_contentIn),
                        child: Row(
                          children: [
                            // ===== Izquierda: 4 cards (ALTURAS CONTROLADAS + AIRE) =====
                            Expanded(
                              flex: 8,
                              child: LayoutBuilder(
                                builder: (_, lc) {
                                  final gap = 18.0 * s;

                                  // altura disponible real (sin header/footer porque ya estás dentro del Padding)
                                  final availH = lc.maxHeight;

                                  // 👇 topRow un poco más chico, bottomRow un poco más grande
                                  final topRowH = (availH * 0.42).clamp(
                                    220.0 * s,
                                    320.0 * s,
                                  );
                                  final bottomRowH = (availH * 0.46).clamp(
                                    240.0 * s,
                                    360.0 * s,
                                  );

                                  // aire arriba/abajo
                                  final used = topRowH + gap + bottomRowH;
                                  final free = (availH - used).clamp(
                                    0.0,
                                    availH,
                                  );
                                  final topAir = free * 0.45; // más aire arriba
                                  final bottomAir = free - topAir;

                                  return Column(
                                    children: [
                                      SizedBox(height: topAir),

                                      SizedBox(
                                        height: topRowH,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _GlassCard(
                                                scale: s,
                                                title: 'Software / OS',
                                                child: _Bullets(
                                                  scale: s,
                                                  bullets: const [
                                                    'Sistema operativo basado en Linux con capacidad de tiempo real (ctrlX OS)',
                                                    'Amplia gama de aplicaciones para la escalabilidad del software',
                                                    'Rendimiento CPU multinúcleo + interfaces opcionales para escalar hardware',
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 18 * s),
                                            Expanded(
                                              child: _GlassCard(
                                                scale: s,
                                                title:
                                                    'Hardware industrial para entornos exigentes',
                                                child: Text(
                                                  'Como controlador embebido, ctrlX CORE ofrece un diseño de hardware industrial basado en una electrome-cánica robusta y sin ventiladores, lo que permite utilizarse en entornos exigentes.',
                                                  style: TextStyle(
                                                    fontSize: 18 * s,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withValues(
                                                          alpha: 0.92,
                                                        ),
                                                    height: 1.45,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: gap),

                                      SizedBox(
                                        height: bottomRowH,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: _GlassCard(
                                                scale: s,
                                                title: 'Beneficios clave',
                                                child: _Bullets(
                                                  scale: s,
                                                  bullets: const [
                                                    'Alto nivel de ciberseguridad',
                                                    'Gestión de dispositivos simplificada y transparente (portal ctrlX)',
                                                    'Diseño industrial duradero',
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 18 * s),
                                            Expanded(
                                              child: _GlassCard(
                                                scale: s,
                                                title:
                                                    'ctrlX OS: acceso a todo el ecosistema',
                                                child: Text(
                                                  'ctrlX CORE ejecuta el sistema operativo ctrlX OS basado en Linux con capacidad de tiempo real. Esto ofrece máxima apertura y acceso a todo el ecosistema ctrlX OS con todos los servicios digitales.',
                                                  style: TextStyle(
                                                    fontSize: 18 * s,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white
                                                        .withValues(
                                                          alpha: 0.92,
                                                        ),
                                                    height: 1.45,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: bottomAir),
                                    ],
                                  );
                                },
                              ),
                            ),

                            SizedBox(width: 22 * s),

                            // ===== Derecha: espacio para imagen grande =====
                            Expanded(
                              flex: 6,
                              child: LayoutBuilder(
                                builder: (_, rc) {
                                  final availH = rc.maxHeight;

                                  // 👇 altura del placeholder (no full height)
                                  final boxH = (availH * 0.82).clamp(
                                    360.0 * s,
                                    availH,
                                  );

                                  return Align(
                                    alignment: Alignment
                                        .center, // centro vertical/horizontal
                                    child: SizedBox(
                                      height: boxH,
                                      child: _ImagePlaceholder(
                                        scale: s,
                                        label: 'ESPACIO PARA IMAGEN',
                                        hint:
                                            'Coloca aquí tu imagen grande (Image.asset / diagramita / foto)',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ===== Footer =====
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FadeTransition(
                    opacity: _fade,
                    child: FooterBand(
                      scale: s,
                      // pageText: '8/49',
                    ),
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

class _HeaderGlass extends StatelessWidget {
  final double scale;
  final String title;
  final String subtitle;

  const _HeaderGlass({
    required this.scale,
    required this.title,
    required this.subtitle,
  });

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
            blurRadius: 26 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10 * scale,
            height: 46 * scale,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 44 * scale,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16 * scale,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.78),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final double scale;
  final String title;
  final Widget child;

  const _GlassCard({
    required this.scale,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22 * scale),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 10 * scale),
          Expanded(child: child),
          SizedBox(height: 10 * scale),
          Container(
            height: 3 * scale,
            width: 140 * scale,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2EC4FF).withValues(alpha: 0.9),
                  const Color(0xFF0B3C6E).withValues(alpha: 0.9),
                  const Color(0xFFFF2B2B).withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  final double scale;
  final List<String> bullets;

  const _Bullets({required this.scale, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bullets.length,
      separatorBuilder: (_, __) => SizedBox(height: 10 * scale),
      itemBuilder: (_, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 22 * scale,
              height: 22 * scale,
              margin: EdgeInsets.only(top: 2 * scale),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.10),
                border: Border.all(
                  color: const Color(0xFF2EC4FF).withValues(alpha: 0.55),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.chevron_right,
                  size: 18 * scale,
                  color: const Color(0xFF2EC4FF),
                ),
              ),
            ),
            SizedBox(width: 10 * scale),
            Expanded(
              child: Text(
                bullets[i],
                style: TextStyle(
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.92),
                  height: 1.25,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  final double scale;
  final String label;
  final String hint;

  const _ImagePlaceholder({
    required this.scale,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26 * scale),
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 22 * scale,
            offset: Offset(0, 12 * scale),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22 * scale),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2EC4FF).withValues(alpha: 0.10),
                    Colors.white.withValues(alpha: 0.03),
                    const Color(0xFFFF2B2B).withValues(alpha: 0.08),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image_outlined,
                  size: 56 * scale,
                  color: Colors.white.withValues(alpha: 0.78),
                ),
                SizedBox(height: 12 * scale),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18 * scale,
                    fontWeight: FontWeight.w900,
                    color: Colors.white.withValues(alpha: 0.92),
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 10 * scale),
                Text(
                  hint,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.70),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
