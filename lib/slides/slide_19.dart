// lib/slides/slide_19.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide19 extends StatefulWidget {
  const Slide19({super.key});

  @override
  State<Slide19> createState() => _Slide19State();
}

class _Slide19State extends State<Slide19> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _leftIn;
  late final Animation<Offset> _rightIn;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );

    _fade = CurvedAnimation(
      parent: _c,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
    );

    _scale = Tween<double>(begin: 0.988, end: 1.0).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.08, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _titleIn =
        Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.00, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    _leftIn = Tween<Offset>(begin: const Offset(-0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.12, 0.92, curve: Curves.easeOutCubic),
      ),
    );

    _rightIn = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.14, 0.98, curve: Curves.easeOutCubic),
      ),
    );

    _c.forward();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  double _scaleByWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return (w / 1366.0).clamp(0.80, 1.18);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";
    const leftBottomImage = "assets/slide19/slide19_1.jpg";
    const rightImage = "assets/slide19/slide19.jpg";

    return Scaffold(
      body: Stack(
        children: [
          _BackgroundImage(asset: bgAsset, s: s),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(28 * s, 18 * s, 28 * s, 128 * s),
              child: FadeTransition(
                opacity: _fade,
                child: ScaleTransition(
                  scale: _scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _titleIn,
                        child: _HeaderGlass(
                          scale: s,
                          title: "Programación IEC y NO-IEC",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ===== LEFT GLASS (TODO EN UN SOLO CARD: título + texto + imagen) =====
                            Expanded(
                              flex: 44,
                              child: SlideTransition(
                                position: _leftIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 30,
                                  padding: EdgeInsets.fromLTRB(
                                    18 * s,
                                    16 * s,
                                    18 * s,
                                    16 * s,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30 * s),
                                    child: Stack(
                                      children: [
                                        // vibe/blur interno suave (para que no se vea “vacío”)
                                        Positioned.fill(
                                          child: IgnorePointer(
                                            child: Opacity(
                                              opacity: 0.10,
                                              child: ImageFiltered(
                                                imageFilter: ImageFilter.blur(
                                                  sigmaX: 22 * s,
                                                  sigmaY: 22 * s,
                                                ),
                                                child: Image.asset(
                                                  leftBottomImage,
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            color: Colors.black.withOpacity(0.10),
                                          ),
                                        ),

                                        // Contenido real
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            _LeftHeaderLight(s: s),
                                            SizedBox(height: 10 * s),

                                            // Texto sin “card extra”: solo un panel suave, pegado al mismo card
                                            Expanded(
                                              flex: 46,
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                  14 * s,
                                                  12 * s,
                                                  14 * s,
                                                  12 * s,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18 * s),
                                                  color: Colors.white.withOpacity(0.06),
                                                  border: Border.all(
                                                    color: Colors.white.withOpacity(0.10),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: _LeftParagraphsLight(s: s),
                                              ),
                                            ),

                                            SizedBox(height: 10 * s),

                                            // separador fino (integra texto+imagen)
                                            Container(
                                              height: 1.2 * s,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Colors.transparent,
                                                    const Color(0xFF2EC4FF)
                                                        .withOpacity(0.45),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),

                                            SizedBox(height: 10 * s),

                                            // Imagen GRANDE, dentro del mismo card (NO “card aparte”)
                                            Expanded(
                                              flex: 54,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18 * s),
                                                child: Stack(
                                                  children: [
                                                    Positioned.fill(
                                                      child: _FitImageToCard(
                                                        s: s,
                                                        asset: leftBottomImage,
                                                        topInset: 10 * s,
                                                        sideInset: 10 * s,
                                                        bottomInset: 10 * s,
                                                        blurOpacity: 0.14,
                                                        overlayOpacity: 0.04,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                    // borde MUY suave para que no parezca otro card
                                                    Positioned.fill(
                                                      child: DecoratedBox(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  18 * s),
                                                          border: Border.all(
                                                            color: Colors.white
                                                                .withOpacity(0.10),
                                                            width: 1.1,
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 18 * s),

                            // ===== RIGHT GLASS: full image =====
                            Expanded(
                              flex: 56,
                              child: SlideTransition(
                                position: _rightIn,
                                child: _GlassCard(
                                  s: s,
                                  radius: 34,
                                  padding: EdgeInsets.zero,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(34 * s),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: _FitImageToCard(
                                            s: s,
                                            asset: rightImage,
                                            topInset: 10 * s,
                                            sideInset: 10 * s,
                                            bottomInset: 10 * s,
                                            blurOpacity: 0.14,
                                            overlayOpacity: 0.06,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(34 * s),
                                              border: Border.all(
                                                color:
                                                    Colors.white.withOpacity(0.14),
                                                width: 1.6,
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
                          ],
                        ),
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
      ),
    );
  }
}

// ===================== HEADER GLASS =====================

class _HeaderGlass extends StatelessWidget {
  final double scale;
  final String title;

  const _HeaderGlass({required this.scale, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18 * scale),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 22 * scale,
            vertical: 14 * scale,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            color: Colors.white.withOpacity(0.10),
            border:
                Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
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
                      const Color(0xFF2EC4FF).withOpacity(0.95),
                      const Color(0xFFFF2B2B).withOpacity(0.85),
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
                    fontSize: 52 * scale,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                    color: Colors.white.withOpacity(0.96),
                    shadows: [
                      Shadow(
                        blurRadius: 22,
                        offset: const Offset(0, 10),
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ],
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

// ===================== LEFT TEXT (WHITE) =====================

class _LeftHeaderLight extends StatelessWidget {
  final double s;
  const _LeftHeaderLight({required this.s});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // 👇 más margen arriba para que no lo coma el clip
      padding: EdgeInsets.only(top: 8 * s, bottom: 2 * s, left: 6 * s),
      child: Text(
        "Interface IDE – Entorno de Desarrollo Integrado",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textHeightBehavior: const TextHeightBehavior(
          // 👇 ayuda a que no se “corte” el primer renglón
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
        style: TextStyle(
          fontSize: 17.8 * s,
          fontWeight: FontWeight.w900,
          height: 1.18,
          color: Colors.white.withOpacity(0.96),
          // 👇 sombra más “safe” (menos hacia arriba)
          shadows: [
            Shadow(
              blurRadius: 16,
              offset: const Offset(0, 6),
              color: Colors.black.withOpacity(0.22),
            ),
          ],
        ),
      ),
    );
  }
}


class _LeftParagraphsLight extends StatelessWidget {
  final double s;
  const _LeftParagraphsLight({required this.s});

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: 15.6 * s,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: RichText(
        text: TextSpan(
          style: base,
          children: [
            TextSpan(
              text: "Codificación Textual ",
              style: base.copyWith(fontWeight: FontWeight.w900),
            ),
            const TextSpan(
              text:
                  "representa un entorno de desarrollo web (editor de código, consola, depuración, etc.) con conectividad nativa con ctrlX CORE. Permite crear scripts de Python o editar archivos en la solución activa.\n\n",
            ),
            TextSpan(
              text: "Visual Coding ",
              style: base.copyWith(fontWeight: FontWeight.w900),
            ),
            const TextSpan(
              text:
                  "proporciona un marco de programación (editor de código, depurador, gestión de proyectos, configuración, etc.) para crear programas basados en elementos visuales, Python y JavaScript. El lenguaje del editor activo se puede cambiar en cualquier momento, lo que facilita el trabajo colaborativo.",
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== GLASS CARD =====================

class _GlassCard extends StatelessWidget {
  final double s;
  final Widget child;
  final double radius;
  final EdgeInsetsGeometry padding;

  const _GlassCard({
    required this.s,
    required this.child,
    this.radius = 26,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius * s;

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(
              color: Colors.white.withOpacity(0.14),
              width: 1.8,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 28,
                offset: const Offset(0, 16),
                color: Colors.black.withOpacity(0.32),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(r),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.10),
                        Colors.transparent,
                        Colors.black.withOpacity(0.08),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== IMAGE FIT (pro) =====================

class _FitImageToCard extends StatelessWidget {
  final double s;
  final String asset;
  final double topInset;
  final double sideInset;
  final double bottomInset;
  final double blurOpacity;
  final double overlayOpacity;
  final BoxFit fit;

  const _FitImageToCard({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
    this.blurOpacity = 0.14,
    this.overlayOpacity = 0.06,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => _ImageFallback(s: s);

    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 18 * s, sigmaY: 18 * s),
            child: Opacity(
              opacity: blurOpacity,
              child: Image.asset(
                asset,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (_, __, ___) => fallback(),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(color: Colors.black.withOpacity(overlayOpacity)),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              sideInset * s,
              topInset * s,
              sideInset * s,
              bottomInset * s,
            ),
            child: Image.asset(
              asset,
              fit: fit,
              alignment: Alignment.center,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) => fallback(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageFallback extends StatelessWidget {
  final double s;
  const _ImageFallback({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Icon(
          Icons.image_rounded,
          size: 54 * s,
          color: Colors.white.withOpacity(0.70),
        ),
      ),
    );
  }
}

// ===================== BACKGROUND =====================

class _BackgroundImage extends StatelessWidget {
  final String asset;
  final double s;
  const _BackgroundImage({required this.asset, required this.s});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.asset(asset, fit: BoxFit.cover)),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.18),
                  Colors.black.withOpacity(0.62),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.0, -0.25),
                radius: 1.20,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.45),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.06,
              child: CustomPaint(painter: _GridPainter(step: 42 * s)),
            ),
          ),
        ),
      ],
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
