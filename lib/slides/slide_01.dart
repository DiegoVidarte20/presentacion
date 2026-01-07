import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

import 'package:presentacion/ui/footer_band.dart';

class Slide01 extends StatefulWidget {
  const Slide01({super.key});

  @override
  State<Slide01> createState() => _Slide01State();
}

class _Slide01State extends State<Slide01> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<Offset> _slideTitle;
  late Animation<Offset> _slideLogo;
  late Animation<double> _scaleDevices;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideTitle = Tween<Offset>(begin: const Offset(-0.3, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          ),
        );

    _slideLogo = Tween<Offset>(begin: const Offset(0.3, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          ),
        );

    _scaleDevices = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutBack),
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
        final h = c.maxHeight;
        final s = (w / 1400).clamp(0.75, 1.25);

        TextStyle t(
          double size, {
          FontWeight fw = FontWeight.w600,
          Color col = Colors.white,
        }) => TextStyle(
          fontSize: size * s,
          fontWeight: fw,
          color: col,
          height: 1.1,
          letterSpacing: 0.5,
        );

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // Fondo con gradiente animado
                // Fondo con imagen
                Positioned.fill(
                  child: Image.asset(
                    'assets/slide1/fondoslide1.jpeg', // <-- cambia a tu ruta real
                    fit: BoxFit.cover,
                  ),
                ),

                // Overlay oscuro suave para legibilidad
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

                // Partículas flotantes
                const Positioned.fill(child: _FloatingParticles()),

                // Títulos top-left
                Positioned(
                  left: 48 * s,
                  top: 34 * s,
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: SlideTransition(
                      position: _slideTitle,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _GlowText('CTRL X CORE', t(44, fw: FontWeight.w500)),
                          const SizedBox(height: 6),
                          _GlowText(
                            'CTRL X CORE Automation',
                            t(44, fw: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Logo top-right
                Positioned(
                  right: 56 * s,
                  top: 30 * s,
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: SlideTransition(
                      position: _slideLogo,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _LogoCtrlX(scale: s),
                          const SizedBox(height: 8),
                          _GlowText(
                            'AUTOMATION',
                            t(
                              28,
                              fw: FontWeight.w300,
                            ).copyWith(letterSpacing: 8 * s),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Los 3 dispositivos
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 70 * s,
                      right: 70 * s,
                      top: 170 * s,
                      bottom: 170 * s,
                    ),
                    child: FadeTransition(
                      opacity: _fadeIn,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _DeviceCard(
                              imagePath: 'assets/slide1/plc.png',
                              label: 'X3',
                              scale: s,
                              delay: 0,
                            ),
                          ),
                          SizedBox(width: 34 * s),
                          Expanded(
                            child: _DeviceCard(
                              imagePath: 'assets/slide1/plc2.png',
                              label: 'X5',
                              scale: s,
                              delay: 200,
                            ),
                          ),
                          SizedBox(width: 34 * s),
                          Expanded(
                            child: _DeviceCard(
                              imagePath: 'assets/slide1/plc3.png',
                              label: 'X7',
                              scale: s,
                              delay: 400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Texto grande abajo
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 128 * s, // ✅ antes: 84*s
                  child: FadeTransition(
                    opacity: _fadeIn,
                    child: Center(
                      child: _GlowText(
                        'DOS PASOS ADELANTE',
                        t(
                          46,
                          fw: FontWeight.w300,
                        ).copyWith(letterSpacing: 14 * s),
                        glowIntensity: 0.6,
                      ),
                    ),
                  ),
                ),

                // Footer tipo “franja blanca” pero premium (glass + borde + barra color)
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

// === Logo CtrlX con efecto glow ===
class _LogoCtrlX extends StatelessWidget {
  final double scale;

  const _LogoCtrlX({required this.scale});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 68 * scale,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(color: const Color(0xFF2EC4FF), blurRadius: 10 * scale),
            ],
          ),
          children: const [
            TextSpan(
              text: 'ctrl',
              style: TextStyle(color: Color(0xFF2EC4FF)),
            ),
            TextSpan(
              text: 'X',
              style: TextStyle(
                color: Color(0xFFFF2B2B),
                shadows: [Shadow(color: Color(0xFFFF2B2B), blurRadius: 10)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === Texto con efecto glow ===
class _GlowText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double glowIntensity;

  const _GlowText(this.text, this.style, {this.glowIntensity = 0.3});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(
        shadows: [
          Shadow(
            color: Colors.white.withValues(alpha: glowIntensity),
            blurRadius: 15,
          ),
          Shadow(
            color: const Color(
              0xFF2EC4FF,
            ).withValues(alpha: glowIntensity * 0.6),
            blurRadius: 25,
          ),
        ],
      ),
    );
  }
}

// === Partículas flotantes de fondo ===
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
                opacity: (0.1 + (value * 0.2)) * ((i % 3 == 0) ? 0.7 : 0.4),
                child: Transform.translate(
                  offset: Offset(0, -20 * value),
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
                                  .withValues(alpha: .5),
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

// === Fondo con gradiente animado ===
class _Bg extends StatelessWidget {
  const _Bg();

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 3000),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(
                  const Color(0xFF000818),
                  const Color(0xFF041A33),
                  value,
                )!,
                const Color(0xFF062A55),
                Color.lerp(
                  const Color(0xFF0B3C6E),
                  const Color(0xFF0D4580),
                  value,
                )!,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.75, -0.35),
                radius: 1.25,
                colors: [
                  Colors.white.withValues(alpha: 0.10 + (value * 0.05)),
                  Colors.transparent,
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF2EC4FF).withValues(alpha: 0.03 * value),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// === Card de dispositivo con hover ===
class _DeviceCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final double scale;
  final int delay; // lo dejo para que no rompa llamadas, pero ya no se usa

  const _DeviceCard({
    required this.imagePath,
    required this.label,
    required this.scale,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: 320 * scale,
            filterQuality: FilterQuality.none,
            isAntiAlias: false,
          ),
          SizedBox(height: 18 * scale),
          Text(
            label,
            style: TextStyle(
              fontSize: 38 * scale,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
