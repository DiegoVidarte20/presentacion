// lib/slides/slide_09.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide09 extends StatefulWidget {
  const Slide09({super.key});

  @override
  State<Slide09> createState() => _Slide09State();
}

class _Slide09State extends State<Slide09> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rightIn;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.00, 1.00, curve: Curves.easeOut),
    );

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.00, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _leftIn = Tween<Offset>(begin: const Offset(-0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.10, 0.70, curve: Curves.easeOutCubic),
          ),
        );

    _rightIn = Tween<Offset>(begin: const Offset(0.10, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _c,
            curve: const Interval(0.18, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _scale(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    // baseline pensado para pantallas tipo 1366-1920
    return (w / 1366.0).clamp(0.85, 1.15);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scale(context);

    return Scaffold(
      body: Stack(
        children: [
          _Background(s: s),

          // Contenido principal (deja espacio al footer)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28 * s, 18 * s, 28 * s, 92 * s),
              child: FadeTransition(
                opacity: _fade,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SlideTransition(
                      position: _titleIn,
                      child: _HeaderTitle(s: s),
                    ),
                    SizedBox(height: 18 * s),

                    // ===== Layout nuevo: cards arriba + tabla abajo =====
                    Expanded(
                      child: Column(
                        children: [
                          // Cards arriba (en fila)
                          SizedBox(
                            height: 240 * s, // ajusta si quieres: 220-280
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: SlideTransition(
                                    position: _leftIn,
                                    child: _InfoCard(
                                      s: s,
                                      icon: Icons.verified_user_rounded,
                                      title:
                                          "Seguro por diseño y\ncumplimiento de estándares",
                                      body:
                                          "La protección de datos es clave en la integración de hardware industrial.\n\n"
                                          "El desarrollo y la certificación se realizan según IEC 62443, alineado a estándares de seguridad actuales.",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16 * s),
                                Expanded(
                                  child: SlideTransition(
                                    position: _rightIn,
                                    child: _InfoCard(
                                      s: s,
                                      icon: Icons.hub_rounded,
                                      title:
                                          "Escalabilidad\nconectada y flexible",
                                      body:
                                          "ctrlX CORE ofrece rendimiento de CPU y memoria (RAM) escalables.\n\n"
                                          "Se adapta a necesidades específicas mediante variantes disponibles.",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 14 * s),

                          // Tabla abajo (se lleva todo el resto)
                          Expanded(
                            child: SlideTransition(
                              position:
                                  _rightIn, // si quieres, hacemos un _tableIn con Offset(0, 0.08)
                              child: _TableCard(s: s),
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

          // Footer reutilizable
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
      ),
    );
  }
}

// ===================== UI PARTS =====================

class _HeaderTitle extends StatelessWidget {
  final double s;
  const _HeaderTitle({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26 * s, vertical: 18 * s),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18 * s),
        color: Colors.white.withOpacity(0.10),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            blurRadius: 26 * s,
            offset: Offset(0, 12 * s),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10 * s,
            height: 46 * s,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2EC4FF).withOpacity(0.95),
                  const Color(0xFFFF2B2B).withOpacity(0.85),
                ],
              ),
            ),
          ),
          SizedBox(width: 14 * s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CtrlX Core - CPU",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 44 * s,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 6 * s),
                Text(
                  "Arquitectura, sistema operativo y ecosistema",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16 * s,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.78),
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


class _ChipPill extends StatelessWidget {
  final double s;
  final String text;
  const _ChipPill({required this.s, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 7 * s),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.14)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.5 * s,
          color: Colors.white.withOpacity(0.92),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final double s;
  final IconData icon;
  final String title;
  final String body;

  const _InfoCard({
    required this.s,
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.all(18 * s),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            border: Border.all(
              color: const Color(0xFF59D7FF).withOpacity(0.30),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(26 * s),
            boxShadow: [
              BoxShadow(
                blurRadius: 22,
                offset: const Offset(0, 12),
                color: Colors.black.withOpacity(0.28),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42 * s,
                    height: 42 * s,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14 * s),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF59D7FF).withOpacity(0.95),
                          const Color(0xFF2B6CFF).withOpacity(0.95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                          color: const Color(0xFF2B6CFF).withOpacity(0.22),
                        ),
                      ],
                    ),
                    child: Icon(icon, color: Colors.white, size: 22 * s),
                  ),
                  SizedBox(width: 12 * s),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.5 * s,
                        height: 1.08,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * s),
              Expanded(
                child: Text(
                  body,
                  style: TextStyle(
                    fontSize: 13.2 * s,
                    height: 1.25,
                    color: Colors.white.withOpacity(0.88),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableCard extends StatelessWidget {
  final double s;
  const _TableCard({required this.s});

  @override
  Widget build(BuildContext context) {
    // Data (basado en tu screenshot)
    final headers = [
      "",
      "CtrlX CORE X3",
      "ctrlX CORE X3 (más)",
      "ctrlX CORE X5 (más)",
      "ctrlX CORE X7 (más)",
    ];

    final section1Title = "Normas y estándares";
    final section1Rows = <_RowData>[
      _RowData("Normas", ["CE, UL, CSA", "CE, UL, CSA", "CE", "CE, UL, CSA"]),
      _RowData("Proceso de dar un título", [
        "Zona industrial clase A",
        "Zona industrial clase A",
        "Zona industrial clase A",
        "Zona industrial clase A",
      ]),
    ];

    final section2Title = "Condiciones ambientales";
    final section2Rows = <_RowData>[
      _RowData("Temperatura admisible (funcionamiento)", [
        "-25 °C a +55 °C\n(sin ventilador hasta 2000 m)",
        "-25 °C a +55 °C\n(sin ventilador hasta 2000 m)",
        "-25 °C a +55 °C\n(sin ventilador hasta 50 °C)",
        "-25 °C a +55 °C\n(refrigeración activa)",
      ]),
      _RowData("Temperatura admisible (almacenamiento)", [
        "-40 °C a +70 °C",
        "-40 °C a +70 °C",
        "-40 °C a +70 °C",
        "-40 °C a +70 °C",
      ]),
      _RowData("Humedad admisible (funcionamiento)", [
        "5 % a 85 %\n(EN 61131-2)",
        "5 % a 85 %\n(EN 61131-2)",
        "5 % a 85 %\n(EN 61131-2)",
        "5 % a 85 %\n(EN 61131-2)",
      ]),
      _RowData("Grado de protección", ["IP20", "IP20", "IP20", "IP20"]),
      _RowData("Categoría de protección", ["III", "III", "III", "III"]),
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(26 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(26 * s),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 26,
                offset: const Offset(0, 14),
                color: Colors.black.withOpacity(0.30),
              ),
            ],
          ),
          child: Column(
            children: [
              _TableTopBar(s: s),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 14 * s),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18 * s),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(18 * s),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Scrollbar(
                        thumbVisibility: false,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(12 * s),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: _ComparisonTable(
                              s: s,
                              headers: headers,
                              sections: [
                                _SectionData(section1Title, section1Rows),
                                _SectionData(section2Title, section2Rows),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableTopBar extends StatelessWidget {
  final double s;
  const _TableTopBar({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16 * s, vertical: 12 * s),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0B2B55).withOpacity(0.55),
            const Color(0xFF0A3D7A).withOpacity(0.30),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.10)),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.table_chart_rounded,
            color: const Color(0xFF59D7FF).withOpacity(0.95),
            size: 18 * s,
          ),
          SizedBox(width: 10 * s),
          Text(
            "Comparativo técnico",
            style: TextStyle(
              fontSize: 14.5 * s,
              color: Colors.white.withOpacity(0.92),
              fontWeight: FontWeight.w800,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          _ChipPill(s: s, text: "CPU / Normas / Ambiente"),
        ],
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  final double s;
  final List<String> headers;
  final List<_SectionData> sections;

  const _ComparisonTable({
    required this.s,
    required this.headers,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    final leftW = 280.0 * s;
    final colW = 220.0 * s;

    final headerStyle = TextStyle(
      fontSize: 12.6 * s,
      color: Colors.white.withOpacity(0.92),
      fontWeight: FontWeight.w800,
    );

    final cellStyle = TextStyle(
      fontSize: 12.2 * s,
      height: 1.25,
      color: Colors.white.withOpacity(0.86),
      fontWeight: FontWeight.w600,
    );

    Widget headerCell(String text, {bool isLeft = false}) {
      return Container(
        width: isLeft ? leftW : colW,
        padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 10 * s),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          border: Border.all(color: Colors.white.withOpacity(0.10)),
        ),
        child: Text(text, style: headerStyle),
      );
    }

    Widget sectionTitle(String text) {
      return Container(
        width: leftW + (colW * (headers.length - 1)),
        padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 10 * s),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF59D7FF).withOpacity(0.12),
              const Color(0xFF2B6CFF).withOpacity(0.08),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: Border.all(color: const Color(0xFF59D7FF).withOpacity(0.22)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.0 * s,
            color: Colors.white.withOpacity(0.95),
            fontWeight: FontWeight.w900,
            letterSpacing: 0.2,
          ),
        ),
      );
    }

    Widget rowCell(
      String text, {
      required double width,
      required bool alt,
      bool isLeft = false,
    }) {
      final base = alt ? 0.035 : 0.02;
      return Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 12 * s, vertical: 12 * s),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(base),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Text(
          text,
          style: isLeft
              ? cellStyle.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withOpacity(0.90),
                )
              : cellStyle,
        ),
      );
    }

    // 👇 Esto es la clave: IntrinsicHeight para que Row tenga alto finito.
    Widget tableRow(List<Widget> cells) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: cells,
        ),
      );
    }

    final children = <Widget>[];

    // header row
    children.add(
      tableRow(
        List.generate(headers.length, (i) {
          return headerCell(headers[i], isLeft: i == 0);
        }),
      ),
    );

    int zebra = 0;
    for (final sec in sections) {
      children.add(SizedBox(height: 10 * s));
      children.add(sectionTitle(sec.title));
      children.add(SizedBox(height: 8 * s));

      for (final r in sec.rows) {
        final alt = (zebra % 2 == 1);
        zebra++;

        children.add(
          tableRow([
            rowCell(r.label, width: leftW, alt: alt, isLeft: true),
            for (int i = 0; i < r.values.length; i++)
              rowCell(r.values[i], width: colW, alt: alt),
          ]),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

// ===================== DATA MODELS =====================

class _RowData {
  final String label;
  final List<String> values;
  _RowData(this.label, this.values);
}

class _SectionData {
  final String title;
  final List<_RowData> rows;
  _SectionData(this.title, this.rows);
}

// ===================== BACKGROUND =====================

class _Background extends StatelessWidget {
  final double s;
  const _Background({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/slide1/fondoslide1.jpeg"), // <-- TU PATH REAL
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
      child: Stack(
        children: [
          // overlay oscuro para que el texto reviente bien
          Positioned.fill(
            child: Container(
              color: const Color(0xFF050B16).withOpacity(0.55),
            ),
          ),

          // glow blobs (siguen igual)
          Positioned(
            left: -120 * s,
            top: -80 * s,
            child: _GlowBlob(s: s, size: 320, opacity: 0.18),
          ),
          Positioned(
            right: -140 * s,
            bottom: 40 * s,
            child: _GlowBlob(s: s, size: 360, opacity: 0.14),
          ),

          // grid (opcional, lo dejo porque se ve pro)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.06,
                child: CustomPaint(painter: _GridPainter(step: 42 * s)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _GlowBlob extends StatelessWidget {
  final double s;
  final double size;
  final double opacity;
  const _GlowBlob({required this.s, required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size * s,
      height: size * s,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFF59D7FF).withOpacity(opacity),
            const Color(0xFF2B6CFF).withOpacity(opacity * 0.45),
            Colors.transparent,
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final double step;
  _GridPainter({required this.step});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) =>
      oldDelegate.step != step;
}
