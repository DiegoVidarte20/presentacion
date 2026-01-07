import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

import 'package:presentacion/ui/footer_band.dart';

class Slide12 extends StatefulWidget {
  const Slide12({super.key});

  @override
  State<Slide12> createState() => _Slide12State();
}

class _Slide12State extends State<Slide12> with SingleTickerProviderStateMixin {
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
      begin: const Offset(0, 0.05),
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

  // ===== Helpers de tabla =====
  TableRow _dividerRow(double s) {
    return TableRow(
      children: List.generate(
        4,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: 10 * s),
          child: Container(
            height: 1,
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ),
      ),
    );
  }

  TableRow _dividerSoftRow(double s) {
    return TableRow(
      children: List.generate(
        4,
        (_) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10 * s),
          child: Container(
            height: 1,
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ),
      ),
    );
  }

  TableRow _protocolRow(
    double s, {
    required String protocol,
    required Color protocolColor,
    required String significado,
    required String tipo,
    required String prioridad,
    required TextStyle td,
    required TextStyle tdSoft,
  }) {
    final cellPad = EdgeInsets.only(top: 2 * s);

    return TableRow(
      children: [
        Padding(
          padding: cellPad,
          child: Text(
            protocol,
            style: td.copyWith(
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
              color: protocolColor,
            ),
          ),
        ),
        Padding(
          padding: cellPad,
          child: Text(significado, style: tdSoft),
        ),
        Padding(
          padding: cellPad,
          child: Text(tipo, style: tdSoft),
        ),
        Padding(
          padding: cellPad,
          child: Text(prioridad, style: tdSoft),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final w = c.maxWidth;
        final s = (w / 1400).clamp(0.75, 1.35);

        TextStyle topTitle() => TextStyle(
              fontSize: 56 * s,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.2,
              height: 1.0,
            );

            TextStyle th() => TextStyle(
            fontSize: 16 * s, // antes 18
            fontWeight: FontWeight.w800,
            color: const Color(0xFF111115),
            height: 1.05,
            );

            TextStyle td() => TextStyle(
            fontSize: 15 * s, // antes 17
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1E),
            height: 1.10,
            );

            TextStyle tdSoft() => TextStyle(
            fontSize: 15 * s, // antes 17
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1A1A1E),
            height: 1.10,
            );

        return AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Stack(
              children: [
                // ===== Fondo =====
                Positioned.fill(
                  child: Image.asset(
                    // si tienes fondo en slide12, cambia:
                    // 'assets/slide12/fondoslide1.jpeg',
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
                          Colors.black.withValues(alpha: 0.28),
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
                      'EtherCAT – Profiles',
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
                      width: 420 * s,
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
                  bottom: 110 * s,
                  child: FadeTransition(
                    opacity: _fade,
                    child: SlideTransition(
                      position: _slideUp,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Izquierda: Imagen 01
                          Expanded(
                            flex: 7,
                            child: _GlassPanel(
                              scale: s,
                              child: Padding(
                                padding: EdgeInsets.all(10 * s),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18 * s),
                                  child: Container(
                                    color: Colors.white.withValues(alpha: 0.85),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/slide12/Imagen_01.png',
                                      fit: BoxFit.contain,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 22 * s),

                          // Derecha: Imagen 02 + tabla
                          Expanded(
                            flex: 7,
                            child: _GlassPanel(
                              scale: s,
                              child: Column(
                                children: [
                                  // Imagen superior
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.all(10 * s),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18 * s),
                                        child: Container(
                                          color:
                                              Colors.white.withValues(alpha: 0.90),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            'assets/slide12/Imagen_02.png',
                                            fit: BoxFit.contain,
                                            filterQuality: FilterQuality.high,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 8 * s),

                                  // Tabla inferior (sin overflow)
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                        16 * s,
                                        6 * s,
                                        16 * s,
                                        16 * s,
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(18 * s),
                                        child: Container(
                                          color:
                                              Colors.white.withValues(alpha: 0.85),
                                          padding: EdgeInsets.all(14 * s),
                                          child: Table(
                                            columnWidths: const {
                                              0: FlexColumnWidth(2.0),
                                              1: FlexColumnWidth(3.0),
                                              2: FlexColumnWidth(4.0),
                                              3: FlexColumnWidth(2.0),
                                            },
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment.top,
                                            children: [
                                              // Header
                                                TableRow(
                                                    children: [
                                                    Padding(
                                                        padding: EdgeInsets.only(bottom: 8 * s),
                                                        child: Text('Protocolo', style: th()),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(bottom: 8 * s),
                                                        child: Text('Significado', style: th()),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(bottom: 8 * s),
                                                        child: Text('Tipo de Dispositivo', style: th()),
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.only(bottom: 1 * s),
                                                        child: Text('Prioridad', style: th()),
                                                    ),
                                                    ],
                                                ),

                                              _dividerRow(s),

                                              // CoE
                                              _protocolRow(
                                                s,
                                                protocol: 'CoE',
                                                protocolColor: const Color(0xFF222222),
                                                significado:
                                                    'CANopen over\nEtherCAT',
                                                tipo:
                                                    'Sensores, E/S,\nActuadores\ngenerales.',
                                                prioridad: 'Media\n(Cíclica)',
                                                td: td(),
                                                tdSoft: tdSoft(),
                                              ),

                                              _dividerSoftRow(s),

                                              // SoE

                                            // ===== ROW 2 =====
                                            _protocolRow(
                                                s,
                                                protocol: 'SoE',
                                                protocolColor: const Color(0xFF222222),
                                                significado: 'SERCOS over\nEtherCAT',
                                                tipo: 'Servo Drives\n(ctrlX DRIVE).',
                                                prioridad: 'Alta\n(Tiempo Real)',
                                                td: td(),
                                                tdSoft: tdSoft(),
                                            ),

                                            _dividerSoftRow(s),

                                            // ===== ROW 3 ===== ✅ FSoE
                                            _protocolRow(
                                                s,
                                                protocol: 'FSoE',
                                                protocolColor: const Color(0xFF222222),
                                                significado: 'FailSafe over\nEtherCAT',
                                                tipo: 'Dispositivos de\nSeguridad\n(SAFEX).',
                                                prioridad: 'Crítica\n(Seguridad)',
                                                td: td(),
                                                tdSoft: tdSoft(),
                                            ),
                                            ],
                                          ),
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

/// ===== Partículas =====
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
