import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide06 extends StatefulWidget {
  const Slide06({super.key});

  @override
  State<Slide06> createState() => _Slide06State();
}

class _Slide06State extends State<Slide06> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<double> _contentIn;

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
    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
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

        // ===== tus 10 imágenes + títulos (solo el título es texto, la imagen va aparte)
        final items = <_TileData>[
          _TileData('assets/slide6/slide6_1.png', 'Built-insecurity'),
          _TileData('assets/slide6/slide6_2.png', 'Drives and motors'),
          _TileData('assets/slide6/slide6_3.png', 'IEC and non-IEC'),
          _TileData('assets/slide6/slide6_4.png', 'Runtime and engineering'),
          _TileData('assets/slide6/slide6_5.png', 'Motion, Robotics and CNC'),
          _TileData('assets/slide6/slide6_6.png', 'SafeLogic and SafeMotion'),
          _TileData('assets/slide6/slide6_7.png', 'EtherCAT and Gigabit Ethernet'),
          _TileData('assets/slide6/slide6_8.png', 'CPU and power'),
          _TileData('assets/slide6/slide6_9.png', 'Box and panel'),
          _TileData('assets/slide6/slide6_10.png', 'Hardware and software'),
        ];

        return AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo con imagen =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // ✅ cámbialo si tu fondo slide6 es otro
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay pro (azul/negro/rojo) + viñeta =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF2EC4FF).withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.32),
                          const Color(0xFFFF2B2B).withValues(alpha: 0.12),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0.1, -0.2),
                        radius: 1.1,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.50),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Header glass =====
                Positioned(
                  left: padX,
                  right: padX,
                  top: 34 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _titleIn,
                      child: _HeaderGlass(
                        scale: s,
                        title: '1. Solución de Automatización Completa',
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
                          begin: 0.985,
                          end: 1.0,
                        ).animate(_contentIn),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ===== Panel izquierdo (bullets) =====
                            SizedBox(
                              width: 430 * s,
                              child: _LeftBulletsCard(scale: s, t: _t),
                            ),

                            SizedBox(width: 26 * s),

                            // ===== Grid derecho (10 imágenes) =====
                            Expanded(
                              child: _Grid10(scale: s, items: items, t: _t),
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

// =================== UI PARTS ===================

class _HeaderGlass extends StatelessWidget {
  final double scale;
  final String title;

  const _HeaderGlass({required this.scale, required this.title});

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
                fontSize: 44 * scale,
                fontWeight: FontWeight.w900,
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

class _LeftBulletsCard extends StatelessWidget {
  final double scale;
  final TextStyle Function(
    double,
    double, {
    FontWeight fw,
    Color col,
    double lh,
    double ls,
  })
  t;

  const _LeftBulletsCard({required this.scale, required this.t});

  @override
  Widget build(BuildContext context) {
    final bullets = const [
      'ctrlX WORKS - Ingeniería',
      'ctrlX CORE - Control',
      'ctrlX DRIVE - Accionamientos',
      'ctrlX I/O - Entradas/Salidas',
      'ctrlX PLC - Lógica',
      'ctrlX MOTION - Movimiento',
      'ctrlX SAFETY - Seguridad',
      'ctrlX HMI - Interfaz',
      'ctrlX IOT - Conectividad',
    ];

    return Container(
      padding: EdgeInsets.all(22 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22 * scale),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 26 * scale,
            offset: Offset(0, 14 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Componentes',
            style: t(
              scale,
              20,
              fw: FontWeight.w900,
              col: Colors.white,
              lh: 1.1,
              ls: 0.2,
            ),
          ),
          SizedBox(height: 10 * scale),
          Container(
            height: 2 * scale,
            width: 160 * scale,
            color: const Color(0xFF2EC4FF).withValues(alpha: 0.55),
          ),
          SizedBox(height: 16 * scale),

          ...bullets.map(
            (b) => Padding(
              padding: EdgeInsets.only(bottom: 10 * scale),
              child: _DotLine(
                scale: scale,
                text: b,
                style: t(
                  scale,
                  20,
                  fw: FontWeight.w600,
                  col: Colors.white.withValues(alpha: 0.90),
                  lh: 1.2,
                  ls: 0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DotLine extends StatelessWidget {
  final double scale;
  final String text;
  final TextStyle style;

  const _DotLine({
    required this.scale,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8 * scale,
          height: 8 * scale,
          margin: EdgeInsets.only(top: 8 * scale),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(width: 12 * scale),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}

class _Grid10 extends StatelessWidget {
  final double scale;
  final List<_TileData> items;
  final TextStyle Function(
    double,
    double, {
    FontWeight fw,
    Color col,
    double lh,
    double ls,
  })
  t;

  const _Grid10({required this.scale, required this.items, required this.t});

  @override
  Widget build(BuildContext context) {
    // Responsive: 5 columnas si hay ancho, si no 4
    return LayoutBuilder(
      builder: (_, c) {
        final cols = c.maxWidth > 880 * scale ? 5 : 4;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
            crossAxisSpacing: 18 * scale,
            mainAxisSpacing: 18 * scale,
            childAspectRatio: 1.05, // cuadradito premium
          ),
          itemBuilder: (_, i) {
            final it = items[i];
            return _ImageTile(
              scale: scale,
              index: i + 1,
              imagePath: it.imagePath,
              title: it.title,
              titleStyle: t(
                scale,
                16,
                fw: FontWeight.w900,
                col: Colors.white,
                lh: 1.15,
                ls: 0.15,
              ),
            );
          },
        );
      },
    );
  }
}

class _ImageTile extends StatelessWidget {
  final double scale;
  final int index;
  final String imagePath;
  final String title;
  final TextStyle titleStyle;

  const _ImageTile({
    required this.scale,
    required this.index,
    required this.imagePath,
    required this.title,
    required this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22 * scale),
        color: Colors.white.withValues(alpha: 0.10),
        border: Border.all(
          color: const Color(0xFF2EC4FF).withValues(alpha: 0.55),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20 * scale),
        child: Stack(
          children: [
            // ===== imagen =====
            Positioned.fill(
              child: Container(
                color: Colors.white.withValues(alpha: 0.96),
                padding: EdgeInsets.all(12 * scale),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),

            // ===== etiqueta superior (número) =====
            Positioned(
              left: 10 * scale,
              top: 10 * scale,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10 * scale,
                  vertical: 6 * scale,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: Colors.black.withValues(alpha: 0.55),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.18),
                  ),
                ),
                child: Text(
                  '$index',
                  style: TextStyle(
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ),

            // ===== banda inferior (título) =====
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12 * scale,
                  vertical: 10 * scale,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.78),
                    ],
                  ),
                ),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: titleStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TileData {
  final String imagePath;
  final String title;
  const _TileData(this.imagePath, this.title);
}
