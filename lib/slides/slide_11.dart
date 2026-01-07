// lib/slides/slide_11.dart
import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

import 'package:presentacion/ui/footer_band.dart';

class Slide11 extends StatefulWidget {
  const Slide11({super.key});

  @override
  State<Slide11> createState() => _Slide11State();
}

class _Slide11State extends State<Slide11> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slideUp;

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
      begin: const Offset(0, 0.06),
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

  static const _cyan = Color(0xFF2EC4FF);
  static const _red = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.35);

        TextStyle body({
          double size = 17,
          FontWeight fw = FontWeight.w400,
          Color col = const Color(0xFF0E0E10),
          double height = 1.25,
        }) =>
            TextStyle(
              fontSize: size * s,
              fontWeight: fw,
              color: col,
              height: height,
              letterSpacing: 0.1,
            );

        TextStyle title({
          double size = 19,
          FontWeight fw = FontWeight.w800,
          Color col = const Color(0xFF0B0B0C),
        }) =>
            TextStyle(
              fontSize: size * s,
              fontWeight: fw,
              color: col,
              height: 1.15,
              letterSpacing: 0.1,
            );

        TextStyle topTitle({
          double size = 48,
          FontWeight fw = FontWeight.w800,
          Color col = Colors.white,
        }) =>
            TextStyle(
              fontSize: size * s,
              fontWeight: fw,
              color: col,
              height: 1.05,
              letterSpacing: 0.2,
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

                // Overlay oscuro suave (misma vibra Slide01)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.28),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),

                // Partículas flotantes (igual Slide01)
                const Positioned.fill(child: _FloatingParticles()),

                // ===== Barra superior (más premium) =====
                Positioned(
                left: 44 * s,
                top: 26 * s,
                child: FadeTransition(
                    opacity: _fade,
                    child: _GlowText(
                    'EtherCAT and Gigabit Ethernet',
                    TextStyle(
                        fontSize: 56 * s,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.2,
                        height: 1.0,
                    ),
                    glowIntensity: 0.55,
                    ),
                ),
                ),

                // Acento cyan debajo del título (sutil, pro)
                Positioned(
                left: 44 * s,
                top: 92 * s,
                child: FadeTransition(
                    opacity: _fade,
                    child: Container(
                    width: 520 * s,
                    height: 4.5 * s,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        gradient: LinearGradient(
                        colors: [
                            const Color(0xFF2EC4FF).withValues(alpha: 0.95),
                            const Color(0xFF2EC4FF).withValues(alpha: 0.15),
                            Colors.transparent,
                        ],
                        ),
                        boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF2EC4FF).withValues(alpha: 0.35),
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
                  bottom: 120 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slideUp,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ---- Columna izquierda ----
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '1. Gigabit Ethernet: El bus de\nIT e Ingeniería',
                                          style: title(),
                                        ),
                                        SizedBox(height: 10 * s),
                                        Expanded(
                                          child: _FitTextBlock(
                                            align: Alignment.topLeft,
                                            child: Text(
                                              'Estos puertos están diseñados para mover grandes volúmenes de datos hacia afuera de la máquina.',
                                              style: body(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 18 * s),
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '2. EtherCAT: El bus de\nautomatización (Tiempo Real)',
                                          style: title(),
                                        ),
                                        SizedBox(height: 8 * s),
                                        Expanded(
                                          child: _FitTextBlock(
                                            align: Alignment.topLeft,
                                            child: Text.rich(
                                              TextSpan(
                                                style: body(),
                                                children: [
                                                  const TextSpan(
                                                    text:
                                                        'EtherCAT es el protocolo estándar que utiliza ',
                                                  ),
                                                  TextSpan(
                                                    text: 'ctrlX',
                                                    style: body(
                                                      fw: FontWeight.w900,
                                                      col: _red,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                    text:
                                                        ' para el control de movimiento y la periferia. Es el “idioma” con el que el PLC se comunica con motores y sensores.',
                                                  ),
                                                ],
                                              ),
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

                          SizedBox(width: 18 * s),

                          // ---- Columna centro ----
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: _FitTextBlock(
                                      align: Alignment.topLeft,
                                      child: Text.rich(
                                        TextSpan(
                                          style: body(),
                                          children: [
                                            TextSpan(
                                              text: 'Velocidad: ',
                                              style: body(
                                                fw: FontWeight.w900,
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  'Funciona a 1000 Mbps (1 Gbps), es decir, 10 veces más rápido que EtherCAT en términos de ancho de banda puro.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14 * s),
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: _FitTextBlock(
                                      align: Alignment.topLeft,
                                      child: Text.rich(
                                        TextSpan(
                                          style: body(),
                                          children: [
                                            TextSpan(
                                              text: 'Función: ',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            TextSpan(
                                              text: '* Ingeniería:\n',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            TextSpan(
                                              text: 'IIoT / Cloud: ',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            const TextSpan(
                                              text: 'Enviar datos a la nube.\n',
                                            ),
                                            TextSpan(
                                              text: 'Comunicación IT: ',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            const TextSpan(
                                              text:
                                                  'Integración con cámaras de visión artificial, servidores ERP o protocolos como OPC UA y MQTT.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14 * s),
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: _FitTextBlock(
                                      align: Alignment.topLeft,
                                      child: Text.rich(
                                        TextSpan(
                                          style: body(),
                                          children: [
                                            TextSpan(
                                              text: 'Velocidad: ',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            const TextSpan(
                                              text: 'Funciona a 100 Mbps.\n',
                                            ),
                                            TextSpan(
                                              text: 'Determinística',
                                              style: body(
                                                fw: FontWeight.w900,
                                                col: _red,
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  ' (capacidad de garantizar que un mensaje llegue en el microsegundo exacto).',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 14 * s),
                                Expanded(
                                  child: _GlassCard(
                                    scale: s,
                                    child: _FitTextBlock(
                                      align: Alignment.topLeft,
                                      child: Text.rich(
                                        TextSpan(
                                          style: body(),
                                          children: [
                                            TextSpan(
                                              text: 'Ventaja: ',
                                              style: body(fw: FontWeight.w900),
                                            ),
                                            const TextSpan(
                                              text:
                                                  'Permite sincronizar más de 200 ejes con una precisión casi perfecta, algo vital para robótica (por ejemplo, integración con ',
                                            ),
                                            TextSpan(
                                              text: 'KUKA',
                                              style: body(
                                                fw: FontWeight.w900,
                                              ),
                                            ),
                                            const TextSpan(text: ').'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 18 * s),

                          // ---- Panel derecho (imagen) ----
                          Expanded(
                            flex: 8,
                            child: _GlassImagePanel(
                              scale: s,
                              imagePath: 'assets/slide11/imagen1.png',
                            ),
                          ),
                        ],
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

/// ===== Texto con glow (igual vibra Slide01) =====
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
                      color: i % 2 == 0
                          ? const Color(0xFF2EC4FF)
                          : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color:
                              (i % 2 == 0
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

/// ===== Glass Card (para que combine con Slide01) =====
class _GlassCard extends StatelessWidget {
  final double scale;
  final Widget child;

  const _GlassCard({
    required this.scale,
    required this.child,
  });

  static const _cyan = Color(0xFF2EC4FF);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12 * scale, sigmaY: 12 * scale),
        child: Container(
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.76), // ✅ más transparente
            borderRadius: BorderRadius.circular(26 * scale),
            border: Border.all(
              color: _cyan.withValues(alpha: 0.85),
              width: 2.4 * scale, // ✅ menos sticker
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.26),
                blurRadius: 22 * scale,
                offset: Offset(0, 12 * scale),
              ),
              BoxShadow(
                color: _cyan.withValues(alpha: 0.12), // ✅ glow sutil
                blurRadius: 28 * scale,
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// ===== Panel imagen en glass =====
class _GlassImagePanel extends StatelessWidget {
  final double scale;
  final String imagePath;

  const _GlassImagePanel({
    required this.scale,
    required this.imagePath,
  });

  static const _cyan = Color(0xFF2EC4FF);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * scale, sigmaY: 10 * scale),
        child: Container(
          padding: EdgeInsets.all(14 * scale),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(30 * scale),
            border: Border.all(
              color: _cyan.withValues(alpha: 0.95),
              width: 3 * scale,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.32),
                blurRadius: 22 * scale,
                offset: Offset(0, 12 * scale),
              ),
              BoxShadow(
                color: _cyan.withValues(alpha: 0.18),
                blurRadius: 28 * scale,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22 * scale),
            child: Container(
              color: Colors.white.withValues(alpha: 0.92),
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// ✅ Auto-fit: si el texto no entra, se reduce sin overflow
class _FitTextBlock extends StatelessWidget {
  final Widget child;
  final Alignment align;

  const _FitTextBlock({
    required this.child,
    this.align = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        return Align(
          alignment: align,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: align,
            child: SizedBox(
              width: c.maxWidth,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
