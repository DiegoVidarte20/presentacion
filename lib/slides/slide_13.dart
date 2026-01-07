// lib/slides/slide_13.dart
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

import 'package:presentacion/ui/footer_band.dart';

class Slide13 extends StatefulWidget {
  const Slide13({super.key});

  @override
  State<Slide13> createState() => _Slide13State();
}

class _Slide13State extends State<Slide13> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slideUp;

  static const _cyan = Color(0xFF2EC4FF);
  static const _red = Color(0xFFE53935);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.05, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.35);

        TextStyle topTitle() => TextStyle(
              fontSize: 58 * s,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
            );

        TextStyle cardText({
          double size = 26,
          FontWeight fw = FontWeight.w800,
          Color col = const Color(0xFF121217),
          double height = 1.12,
        }) =>
            TextStyle(
              fontSize: size * s,
              fontWeight: fw,
              color: col,
              height: height,
            );

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo =====
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide11/fondoslide1.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay oscuro
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.25),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),

                // Partículas
                const Positioned.fill(child: _FloatingParticles()),

                // ===== Header =====
                Positioned(
                  left: 44 * s,
                  top: 26 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: _GlowText(
                      'Built in Security',
                      topTitle(),
                      glowIntensity: 0.55,
                    ),
                  ),
                ),
                Positioned(
                  left: 44 * s,
                  top: 92 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: Container(
                      width: 380 * s,
                      height: 4.5 * s,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        gradient: LinearGradient(
                          colors: [
                            _cyan.withValues(alpha: 0.95),
                            _cyan.withValues(alpha: 0.18),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _cyan.withValues(alpha: 0.35),
                            blurRadius: 18 * s,
                            offset: Offset(0, 6 * s),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Contenido =====
                Positioned(
                  left: 28 * s,
                  right: 28 * s,
                  top: 128 * s,
                  bottom: 92 * s, // espacio footer
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slideUp,
                      child: LayoutBuilder(
                        builder: (_, cc) {
                          final W = cc.maxWidth;
                          final H = cc.maxHeight;
                          final gap = 18 * s;

                          // --- Layout base ---
                          final leftPanelW = W * 0.42;
                          final rightAreaW = W - leftPanelW - gap;

                          final leftTopH = H * 0.44; // imagen izquierda
                          final miniH = H * 0.28; // fila superior cards
                          final rightBigH = H * 0.60; // imagen grande derecha
                          final capa2H = H * 0.18; // card largo izquierda

                          final miniW = (rightAreaW - gap * 3) / 4;

                          // Triángulo (zona inferior bajo la card larga)
                          final triTop = leftTopH + gap + capa2H + gap;
                          final triH = (H - triTop).clamp(0.0, H);
                          final topTriH = triH * 0.55;
                          final bottomTriH = triH * 0.45;
                          final triGap = 14 * s;

                          final topCardW = (leftPanelW - triGap) / 2;

                          return Stack(
                            children: [
                              // ===== Izquierda: Imagen 1 =====
                              Positioned(
                                left: 0,
                                top: 0,
                                width: leftPanelW,
                                height: leftTopH,
                                child: _GlassPanel(
                                  scale: s,
                                  child: Padding(
                                    padding: EdgeInsets.all(10 * s),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(18 * s),
                                      child: Container(
                                        color: Colors.white
                                            .withValues(alpha: 0.90),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/slide13/Imagen1.png',
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // ===== Top row mini cards (4) =====
                              Positioned(
                                left: leftPanelW + gap,
                                top: 0,
                                width: rightAreaW,
                                height: miniH,
                                child: Row(
                                  children: [
                                    _MiniCard(
                                      scale: s,
                                      width: miniW,
                                      child: Text(
                                        'Capa 3:\nSeguridad de\nRed y\nComunicaciones',
                                        textAlign: TextAlign.center,
                                        style: cardText(size: 24),
                                      ),
                                    ),
                                    SizedBox(width: gap),
                                    _MiniCard(
                                      scale: s,
                                      width: miniW,
                                      child: Text(
                                        'Capa 4: Gestión\nde\nUsuarios y\nAccesos\n(RBAC)',
                                        textAlign: TextAlign.center,
                                        style: cardText(size: 24),
                                      ),
                                    ),
                                    SizedBox(width: gap),
                                    _MiniCard(
                                      scale: s,
                                      width: miniW,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: cardText(size: 24),
                                          children: [
                                            const TextSpan(text: '2.- '),
                                            TextSpan(
                                              text: 'Secure by\nDesign',
                                              style: cardText(size: 24)
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: _red,
                                                decorationThickness: 2.2 * s,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '\n("Seguro\npor diseño")',
                                              style: cardText(
                                                size: 22,
                                                fw: FontWeight.w700,
                                                height: 1.10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: gap),
                                    _MiniCard(
                                      scale: s,
                                      width: miniW,
                                      child: Text(
                                        '3.\nAlineación\ncon\nEstándares\nInternacionales',
                                        textAlign: TextAlign.center,
                                        style: cardText(size: 24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // ===== Derecha: Imagen grande =====
                              Positioned(
                                left: leftPanelW + gap,
                                top: miniH + gap,
                                width: rightAreaW,
                                height: rightBigH,
                                child: _GlassPanel(
                                  scale: s,
                                  child: Padding(
                                    padding: EdgeInsets.all(10 * s),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(18 * s),
                                      child: Container(
                                        color: Colors.white
                                            .withValues(alpha: 0.90),
                                        alignment: Alignment.center,
                                        child: Image.asset(
                                          'assets/slide13/Imagen2.png',
                                          fit: BoxFit.contain,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // ===== Medio izquierda: Capa 2 (largo) =====
                              Positioned(
                                left: 0,
                                top: leftTopH + gap,
                                width: leftPanelW,
                                height: capa2H,
                                child: _GlassPanel(
                                  scale: s,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18 * s),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          style: cardText(size: 30),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'Capa 2: Aislamiento\nde Aplicaciones ',
                                            ),
                                            TextSpan(
                                              text: '(Sandboxing)',
                                              style: cardText(size: 30)
                                                  .copyWith(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: _red,
                                                decorationThickness: 2.4 * s,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // ===== TRIÁNGULO INFERIOR: 2 arriba + 1 abajo centro =====
                              if (triH > 10)
                                Stack(
                                  children: [
                                    // Arriba izquierda
                                    Positioned(
                                      left: 0,
                                      top: triTop,
                                      width: topCardW,
                                      height: topTriH,
                                      child: _GlassPanel(
                                        scale: s,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14 * s),
                                            child: Text(
                                              '1.- La\nArquitectura de\nDiseño: Defensa en\nProfundidad',
                                              textAlign: TextAlign.center,
                                              style: cardText(size: 24),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Arriba derecha
                                    Positioned(
                                      left: topCardW + triGap,
                                      top: triTop,
                                      width: topCardW,
                                      height: topTriH,
                                      child: _GlassPanel(
                                        scale: s,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14 * s),
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: cardText(size: 22),
                                                children: [
                                                  const TextSpan(
                                                    text:
                                                        'Capa 2: Aislamiento\nde Aplicaciones ',
                                                  ),
                                                  TextSpan(
                                                    text: '(Sandboxing)',
                                                    style: cardText(size: 22)
                                                        .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      decorationColor: _red,
                                                      decorationThickness:
                                                          2.0 * s,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Abajo centro
                                    Positioned(
                                      left: leftPanelW * 0.12,
                                      top: triTop + topTriH + triGap,
                                      width: leftPanelW * 0.76,
                                      height: (bottomTriH - triGap).clamp(
                                          10.0, bottomTriH),
                                      child: _GlassPanel(
                                        scale: s,
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16 * s),
                                            child: Text(
                                              'Capa 1: Hardware y\nSistema Operativo\nBase (El Cimiento)',
                                              textAlign: TextAlign.center,
                                              style: cardText(size: 23),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
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

/// ===== Mini card (arriba) =====
class _MiniCard extends StatelessWidget {
  final double scale;
  final double width;
  final Widget child;

  const _MiniCard({
    required this.scale,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: _GlassPanel(
        scale: scale,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * scale),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// ===== Panel glass =====
class _GlassPanel extends StatelessWidget {
  final double scale;
  final Widget child;

  const _GlassPanel({
    required this.scale,
    required this.child,
  });

  static const _cyan = Color(0xFF2EC4FF);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12 * scale, sigmaY: 12 * scale),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(30 * scale),
            border: Border.all(
              color: _cyan.withValues(alpha: 0.85),
              width: 2.6 * scale,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.26),
                blurRadius: 22 * scale,
                offset: Offset(0, 12 * scale),
              ),
              BoxShadow(
                color: _cyan.withValues(alpha: 0.12),
                blurRadius: 30 * scale,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// ===== Texto con glow =====
class _GlowText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double glowIntensity;

  const _GlowText(this.text, this.style, {this.glowIntensity = 0.35});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        shadows: [
          Shadow(
            color: Colors.white.withValues(alpha: glowIntensity),
            blurRadius: 16,
          ),
          Shadow(
            color: const Color(0xFF2EC4FF)
                .withValues(alpha: glowIntensity * 0.65),
            blurRadius: 28,
          ),
        ],
      ),
    );
  }
}

/// ===== Partículas flotantes =====
class _FloatingParticles extends StatelessWidget {
  const _FloatingParticles();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(15, (i) {
        final random = (i * 137.5) % 1;
        return Positioned(
          left: (random * 100) % 100,
          top: ((i * 23) % 100).toDouble(),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: Duration(milliseconds: 2000 + (i * 200)),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: (0.10 + (value * 0.22)) * ((i % 3 == 0) ? 0.7 : 0.4),
                child: Transform.translate(
                  offset: Offset(0, -18 * value),
                  child: Container(
                    width: 2 + (i % 4).toDouble(),
                    height: 2 + (i % 4).toDouble(),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i % 2 == 0 ? const Color(0xFF2EC4FF) : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: (i % 2 == 0
                                  ? const Color(0xFF2EC4FF)
                                  : Colors.white)
                              .withValues(alpha: .50),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
