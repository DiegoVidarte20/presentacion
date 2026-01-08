import 'package:flutter/material.dart';
import 'dart:ui' show ImageFilter;

class FooterBand extends StatelessWidget {
  final double scale;

  // Texto izquierda
  final String line1;
  final String line2;

  // ✅ Logo fijo (global) para todos los slides
  static const String _logoAsset =
      'assets/slide1/logo-rex.png'; // <-- CAMBIA TU RUTA REAL
  static const double _logoHeight = 28; // altura base (se multiplica por scale)

  const FooterBand({
    super.key,
    required this.scale,
    this.line1 = 'Bosch Rexroth Perú | 16.08.2024',
    this.line2 = 'Av. Argentina 3618, Callao, PE',
  });

  TextStyle _t(
    double size, {
    FontWeight fw = FontWeight.w600,
    Color col = Colors.black,
  }) => TextStyle(
    fontSize: size * scale,
    fontWeight: fw,
    color: col,
    height: 1.1,
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    final h = 78.0 * scale;
    final padX = 44.0 * scale;

    return SizedBox(
      height: h + (10 * scale),
      child: Stack(
        children: [
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
                    color: Colors.white.withValues(alpha: 0.96),
                    border: Border(
                      top: BorderSide(
                        color: Colors.black.withValues(alpha: 0.10),
                        width: 1,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 26 * scale,
                        spreadRadius: 2 * scale,
                        color: Colors.black.withValues(alpha: 0.18),
                        offset: Offset(0, -6 * scale),
                      ),
                    ],
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: padX),
                    child: Row(
                      children: [
                        // ===== Izquierda (Info) =====
                        Expanded(
                          child: DefaultTextStyle(
                            style: _t(
                              12,
                              fw: FontWeight.w600,
                              col: Colors.black.withValues(alpha: 0.85),
                            ).copyWith(letterSpacing: 0.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(line1),
                                SizedBox(height: 4 * scale),
                                Text(
                                  line2,
                                  style: _t(
                                    12,
                                    fw: FontWeight.w500,
                                    col: Colors.black.withValues(alpha: 0.70),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // ===== Derecha (Logo fijo) =====
                        Opacity(
                          opacity: 0.98,
                          child: SizedBox(
                            height: 44 * scale, // 👈 antes 28, ahora más grande
                            width:
                                220 *
                                scale, // 👈 reserva espacio para que no se comprima
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                _logoAsset,
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ===== Barra inferior color =====
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
