import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide04 extends StatefulWidget {
  const Slide04({super.key});

  @override
  State<Slide04> createState() => _Slide04State();
}

class _Slide04State extends State<Slide04> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<double> _gridIn;

  final List<_ReasonItem> _items = const [
    _ReasonItem(
      n: 1,
      title: 'Solución Completa',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(n: 2, title: 'Menos es Más', image: 'assets/slide2/icono1.jpeg'),
    _ReasonItem(
      n: 3,
      title: 'Rendimiento Consistente',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(
      n: 4,
      title: 'Siempre Conectado',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(
      n: 5,
      title: 'Arquitectura Uniforme',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(
      n: 6,
      title: 'Sistema Más Abierto',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(n: 7, title: 'Integración IoT', image: 'assets/slide2/icono1.jpeg'),
    _ReasonItem(
      n: 8,
      title: 'Revolución Ingeniería',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(
      n: 9,
      title: 'Servicio a Largo Plazo',
      image: 'assets/slide2/icono1.jpeg',
    ),
    _ReasonItem(
      n: 10,
      title: 'Futuro Garantizado',
      image: 'assets/slide2/icono1.jpeg',
    ),
  ];

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
    _titleIn = Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.05, 0.45, curve: Curves.easeOutCubic),
          ),
        );
    _gridIn = CurvedAnimation(
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
                // ===== Fondo (imagen) =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // cámbialo si tu fondo slide4 es otro
                    fit: BoxFit.cover,
                  ),
                ),

                // ===== Overlay (para que el texto reviente bien) =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF2EC4FF).withValues(alpha: 0.18),
                          Colors.black.withValues(alpha: 0.25),
                          const Color(0xFFFF2B2B).withValues(alpha: 0.16),
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
                          Colors.black.withValues(alpha: 0.15),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Título (glass header) =====
                Positioned(
                  left: padX,
                  right: padX,
                  top: 32 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _titleIn,
                      child: _TopTitle(scale: s),
                    ),
                  ),
                ),

                // ===== Grid (10 cards) =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      padX,
                      160 * s,
                      padX,
                      footerSpace,
                    ),
                    child: FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.98,
                          end: 1.0,
                        ).animate(_gridIn),
                        child: _ReasonsGrid(scale: s, items: _items),
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

class _TopTitle extends StatelessWidget {
  final double scale;
  const _TopTitle({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 28 * scale,
        vertical: 18 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22 * scale),
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
            height: 52 * scale,
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
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '10 Buenas Razones.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 44 * scale,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.2,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 6 * scale),
                Text(
                  'Solo Soluciones Perfectas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42 * scale,
                    fontWeight: FontWeight.w800,
                    color: Colors.white.withValues(alpha: 0.95),
                    letterSpacing: 0.2,
                    height: 1.05,
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

class _ReasonsGrid extends StatelessWidget {
  final double scale;
  final List<_ReasonItem> items;

  const _ReasonsGrid({required this.scale, required this.items});

  @override
  Widget build(BuildContext context) {
    // 5 columnas x 2 filas (como tu ejemplo)
    return LayoutBuilder(
      builder: (_, c) {
        final crossAxisCount = 5;
        final gap = 18.0 * scale;

        final itemW =
            (c.maxWidth - gap * (crossAxisCount - 1)) / crossAxisCount;
        final itemH = itemW * 0.92; // “cuadrado pro” sin verse aplastado

        return Center(
          child: Wrap(
            spacing: gap,
            runSpacing: gap,
            children: List.generate(items.length, (i) {
              return SizedBox(
                width: itemW,
                height: itemH,
                child: _ReasonCard(scale: scale, item: items[i]),
              );
            }),
          ),
        );
      },
    );
  }
}

class _ReasonCard extends StatelessWidget {
  final double scale;
  final _ReasonItem item;

  const _ReasonCard({required this.scale, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22 * scale),
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.28),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Column(
        children: [
          // bloque imagen (solo la imagen, ya tiene su texto dentro)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16 * scale),
              child: Container(
                color: Colors.white.withValues(alpha: 0.90), // marco blanco pro
                child: Padding(
                  padding: EdgeInsets.all(10 * scale),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                    isAntiAlias: true,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 12 * scale),

          Text(
            '${item.n}. ${item.title}',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 0.2,
              height: 1.15,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReasonItem {
  final int n;
  final String title;
  final String image;
  const _ReasonItem({
    required this.n,
    required this.title,
    required this.image,
  });
}
