import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

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
                const Positioned.fill(child: _Bg()),

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
                  bottom: 84 * s,
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
                    child: _FooterBand(scale: s, t: t),
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
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2EC4FF).withValues(alpha: .4),
            blurRadius: 30 * scale,
            spreadRadius: 5 * scale,
          ),
          BoxShadow(
            color: const Color(0xFFFF2B2B).withValues(alpha: .3),
            blurRadius: 20 * scale,
            spreadRadius: 3 * scale,
          ),
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 68 * scale,
            fontWeight: FontWeight.w800,
            shadows: [
              Shadow(color: const Color(0xFF2EC4FF), blurRadius: 20 * scale),
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
                shadows: [Shadow(color: Color(0xFFFF2B2B), blurRadius: 20)],
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
class _DeviceCard extends StatefulWidget {
  final String imagePath;
  final String label;
  final double scale;
  final int delay;

  const _DeviceCard({
    required this.imagePath,
    required this.label,
    required this.scale,
    required this.delay,
  });

  @override
  State<_DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<_DeviceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 800 + widget.delay),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -15.0 * widget.scale : 0.0)
              ..scale(_isHovered ? 1.05 : 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ IMAGEN SIN FILTROS / SIN EFECTOS (solo la imagen)
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.contain,
                  height: 320 * widget.scale,
                  filterQuality: FilterQuality.none,
                  isAntiAlias: false,
                ),

                SizedBox(height: 18 * widget.scale),

                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: (38 + (_isHovered ? 4 : 0)) * widget.scale,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1.5,
                    shadows: _isHovered
                        ? [
                            const Shadow(
                              color: Color(0xFF2EC4FF),
                              blurRadius: 15,
                            ),
                            const Shadow(color: Colors.white, blurRadius: 8),
                          ]
                        : [],
                  ),
                  child: Text(widget.label),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FooterBand extends StatelessWidget {
  final double scale;
  final TextStyle Function(double, {FontWeight fw, Color col}) t;

  const _FooterBand({required this.scale, required this.t});

  @override
  Widget build(BuildContext context) {
    final h = 78.0 * scale; // altura franja
    final padX = 44.0 * scale;

    return SizedBox(
      height: h + (10 * scale), // + barra inferior
      child: Stack(
        children: [
          // Fondo glassy (no blanco plano)
          Positioned.fill(
            bottom: 10 * scale,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14 * scale),
                topRight: Radius.circular(14 * scale),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10 * scale,
                  sigmaY: 10 * scale,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.18),
                      ],
                    ),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.16),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 30 * scale,
                        spreadRadius: 2 * scale,
                        color: Colors.black.withValues(alpha: 0.25),
                        offset: Offset(0, -6 * scale),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padX),
                    child: Row(
                      children: [
                        // Info pequeña izquierda (tipo PPT)
                        Expanded(
                          child: DefaultTextStyle(
                            style: t(
                              12,
                              fw: FontWeight.w500,
                              col: Colors.white.withValues(alpha: 0.85),
                            ).copyWith(letterSpacing: 0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Bosch Rexroth Perú | 16.08.2024'),
                                SizedBox(height: 4 * scale),
                                Text(
                                  'Av. Argentina 3618, Callao, PE',
                                  style: t(
                                    12,
                                    fw: FontWeight.w400,
                                    col: Colors.white.withValues(alpha: 0.70),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Marca derecha (más fina, menos “bloque”)
                        Opacity(
                          opacity: 0.92,
                          child: Row(
                            children: [
                              Text(
                                'rexroth',
                                style: t(
                                  28,
                                  fw: FontWeight.w800,
                                ).copyWith(letterSpacing: 0.5),
                              ),
                              SizedBox(width: 10 * scale),
                              Text(
                                'A Bosch Company',
                                style: t(
                                  12,
                                  fw: FontWeight.w500,
                                  col: Colors.white.withValues(alpha: 0.70),
                                ),
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
          ),

          // Barra inferior tipo “línea de color” (no chirriante)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 10 * scale,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2EC4FF).withValues(alpha: 0.95),
                    const Color(0xFF0B3C6E).withValues(alpha: 0.95),
                    const Color(0xFFFF2B2B).withValues(alpha: 0.95),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 12 * scale,
                    offset: Offset(0, -2 * scale),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
