// lib/slides/slide_07.dart
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide07 extends StatefulWidget {
  const Slide07({super.key});

  @override
  State<Slide07> createState() => _Slide07State();
}

class _Slide07State extends State<Slide07> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<double> _cardsIn;

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
    _cardsIn = CurvedAnimation(
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

        // ====== DATA (edita textos + rutas) ======
        final bg = 'assets/slide1/fondoslide1.jpeg'; 

        final items = <_CpuCardData>[
          _CpuCardData(
            tag: 'ctrlX CORE X3',
            imagePath: 'assets/slide7/slide7_1.jpeg',
            bullets: const [
              'ARM de cuatro núcleos de 64 bits',
              'Ethernet de 3 Gbit, eMMC de 4 GB',
              'RAM de 2 GB',
              'Perfecto para aplicaciones de industria 4.0',
            ],
          ),
          _CpuCardData(
            tag: 'ctrlX CORE más X5',
            imagePath: 'assets/slide7/slide7_2.jpeg',
            bullets: const [
              'Intel ATOM de cuatro núcleos',
              'Ethernet de 5 Gbit, 16 GB de memoria',
              '8 GB de RAM',
              'Control gama media para automatización',
            ],
          ),
          _CpuCardData(
            tag: 'ctrlX CORE más X3',
            imagePath: 'assets/slide7/slide7_3.jpeg', 
            bullets: const [
              'ARM de cuatro núcleos de 64 bits',
              '3x Gbit Ethernet, 4 GB de memoria',
              '2 GB de RAM',
              'Flexible por interfaces opcionales + IO local',
            ],
          ),
          _CpuCardData(
            tag: 'ctrlX CORE más X7',
            imagePath: 'assets/slide7/slide7_4.jpeg',
            bullets: const [
              'Intel Core i7 – refrigeración activa',
              'Ethernet de 5 Gbit, 32 GB de memoria',
              '16 GB de RAM',
              'Alto rendimiento multinúcleo (apps exigentes)',
            ],
          ),
        ];

        return AnimatedBuilder(
          animation: _c,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo =====
                Positioned.fill(child: Image.asset(bg, fit: BoxFit.cover)),

                // ===== Overlay cinematic =====
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF2EC4FF).withValues(alpha: 0.16),
                          Colors.black.withValues(alpha: 0.28),
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
                          Colors.black.withValues(alpha: 0.18),
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
                      child: _HeaderGlass(scale: s, title: 'CtrlX Core - CPU'),
                    ),
                  ),
                ),

                // ===== Content (4 cards 2x2) =====
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      padX,
                      (topHeader + 96 * s), // gap bajo el header
                      padX,
                      footerSpace,
                    ),
                    child: FadeTransition(
                      opacity: _fade,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.985,
                          end: 1.0,
                        ).animate(_cardsIn),
                        child: _Grid4(scale: s, items: items, maxW: w, maxH: h),
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
                      // pageText: '7/49', // si lo estás pasando desde Slides.dart, mejor ahí
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
            blurRadius: 26 * scale,
            offset: Offset(0, 12 * scale),
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

class _Grid4 extends StatelessWidget {
  final double scale;
  final List<_CpuCardData> items;
  final double maxW;
  final double maxH;

  const _Grid4({
    required this.scale,
    required this.items,
    required this.maxW,
    required this.maxH,
  });

  @override
  Widget build(BuildContext context) {
    final gap = 16.0 * scale;


    // Ajuste responsivo: si la altura es poca, reduce un poquito el alto del card
    final cardH = (maxH * 0.315).clamp(240.0 * scale, 360.0 * scale);


    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _CpuCard(scale: scale, data: items[0], height: cardH),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _CpuCard(scale: scale, data: items[1], height: cardH),
              ),
            ],
          ),
        ),
        SizedBox(height: gap),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: _CpuCard(scale: scale, data: items[2], height: cardH),
              ),
              SizedBox(width: gap),
              Expanded(
                child: _CpuCard(scale: scale, data: items[3], height: cardH),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CpuCardData {
  final String tag;
  final String imagePath;
  final List<String> bullets;

  const _CpuCardData({
    required this.tag,
    required this.imagePath,
    required this.bullets,
  });
}

class _CpuCard extends StatelessWidget {
  final double scale;
  final _CpuCardData data;
  final double height;

  const _CpuCard({
    required this.scale,
    required this.data,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final r = 22.0 * scale;

    return Container(
      height: height,
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(r),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18 * scale,
            offset: Offset(0, 10 * scale),
          ),
        ],
      ),
      child: Row(
        children: [
          // ===== Imagen (izq) =====
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18 * scale),
              child: Container(
                color: Colors.white.withValues(alpha: 0.92),
                child: Padding(
                  padding: EdgeInsets.all(10 * scale),
                  child: Image.asset(data.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          SizedBox(width: 16 * scale),

          // ===== Texto (der) =====
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TagPill(scale: scale, text: data.tag),
                SizedBox(height: 10 * scale),

                // 👇 esto evita overflow sí o sí
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics:
                        const NeverScrollableScrollPhysics(), // no scroll visible
                    itemCount: data.bullets.length.clamp(0, 4),
                    separatorBuilder: (_, __) => SizedBox(height: 8 * scale),
                    itemBuilder: (_, i) =>
                        _Bullet(scale: scale, text: data.bullets[i]),
                  ),
                ),

                SizedBox(height: 10 * scale),

                // mini acento abajo (siempre entra)
                Container(
                  height: 3 * scale,
                  width: 120 * scale,
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
          ),
        ],
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  final double scale;
  final String text;

  const _TagPill({required this.scale, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14 * scale,
        vertical: 10 * scale,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF2EC4FF).withValues(alpha: 0.28),
            Colors.white.withValues(alpha: 0.06),
            const Color(0xFFFF2B2B).withValues(alpha: 0.22),
          ],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18 * scale,
          fontWeight: FontWeight.w900,
          color: Colors.white.withValues(alpha: 0.95),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final double scale;
  final String text;

  const _Bullet({required this.scale, required this.text});

  @override
  Widget build(BuildContext context) {
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
            text,
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.90),
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}
