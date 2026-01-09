// lib/slides/slide_27.dart
import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:presentacion/ui/footer_band.dart';

class Slide27 extends StatefulWidget {
  const Slide27({super.key});

  @override
  State<Slide27> createState() => _Slide27State();
}

class _Slide27State extends State<Slide27> with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<Offset> _titleIn;
  late final Animation<Offset> _c1In;
  late final Animation<Offset> _c2In;
  late final Animation<Offset> _c3In;

  @override
  void initState() {
    super.initState();

    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1180),
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

    _titleIn = Tween<Offset>(begin: const Offset(0, -0.10), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.00, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    _c1In = Tween<Offset>(begin: const Offset(-0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.14, 0.96, curve: Curves.easeOutCubic),
      ),
    );

    _c2In = Tween<Offset>(begin: const Offset(0.00, 0.05), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.18, 0.98, curve: Curves.easeOutCubic),
      ),
    );

    _c3In = Tween<Offset>(begin: const Offset(0.06, 0.04), end: Offset.zero)
        .animate(
      CurvedAnimation(
        parent: _c,
        curve: const Interval(0.22, 0.99, curve: Curves.easeOutCubic),
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
    return (w / 1366.0).clamp(0.78, 1.22);
  }

  @override
  Widget build(BuildContext context) {
    final s = _scaleByWidth(context);

    const bgAsset = "assets/slide1/fondoslide1.jpeg";

    // ✅ Imagen SOLO para el primer card (cámbiala a tu path real)
    const safetyImg = "assets/slide27/slide27.png";

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
                          title: "SafeLogic and SafeMotion",
                        ),
                      ),
                      SizedBox(height: 14 * s),

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, c) {
                            final w = c.maxWidth;

                            // 🔥 Responsive: si está angosto, apila (2 arriba + 1 abajo)
                            final compact = w < 1120 * s;

                            if (!compact) {
                              // ===== 3 CARDS EN FILA =====
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: SlideTransition(
                                      position: _c1In,
                                      child: _GlassCard(
                                        s: s,
                                        radius: 42,
                                        padding: EdgeInsets.fromLTRB(
                                          18 * s,
                                          16 * s,
                                          18 * s,
                                          16 * s,
                                        ),
                                        child: _Card1Content(s: s, img: safetyImg),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18 * s),
                                  Expanded(
                                    child: SlideTransition(
                                      position: _c2In,
                                      child: _GlassCard(
                                        s: s,
                                        radius: 42,
                                        padding: EdgeInsets.fromLTRB(
                                          18 * s,
                                          16 * s,
                                          18 * s,
                                          16 * s,
                                        ),
                                        child: _Card2Content(s: s),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 18 * s),
                                  Expanded(
                                    child: SlideTransition(
                                      position: _c3In,
                                      child: _GlassCard(
                                        s: s,
                                        radius: 42,
                                        padding: EdgeInsets.fromLTRB(
                                          18 * s,
                                          16 * s,
                                          18 * s,
                                          16 * s,
                                        ),
                                        child: _Card3Content(s: s),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }

                            // ===== COMPACT (2 ARRIBA + 1 ABAJO) =====
                            return Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SlideTransition(
                                          position: _c1In,
                                          child: _GlassCard(
                                            s: s,
                                            radius: 42,
                                            padding: EdgeInsets.fromLTRB(
                                              18 * s,
                                              16 * s,
                                              18 * s,
                                              16 * s,
                                            ),
                                            child: _Card1Content(s: s, img: safetyImg),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 18 * s),
                                      Expanded(
                                        child: SlideTransition(
                                          position: _c2In,
                                          child: _GlassCard(
                                            s: s,
                                            radius: 42,
                                            padding: EdgeInsets.fromLTRB(
                                              18 * s,
                                              16 * s,
                                              18 * s,
                                              16 * s,
                                            ),
                                            child: _Card2Content(s: s),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 18 * s),
                                Expanded(
                                  child: SlideTransition(
                                    position: _c3In,
                                    child: _GlassCard(
                                      s: s,
                                      radius: 42,
                                      padding: EdgeInsets.fromLTRB(
                                        18 * s,
                                        16 * s,
                                        18 * s,
                                        16 * s,
                                      ),
                                      child: _Card3Content(s: s),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

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

// ===================== CARD 1 =====================

class _Card1Content extends StatelessWidget {
  final double s;
  final String img;
  const _Card1Content({required this.s, required this.img});

  @override
  Widget build(BuildContext context) {
    final h = TextStyle(
      fontSize: 22 * s,
      height: 1.05,
      fontWeight: FontWeight.w900,
      color: Colors.white.withOpacity(0.96),
      shadows: [
        Shadow(
          blurRadius: 14,
          offset: const Offset(0, 8),
          color: Colors.black.withOpacity(0.20),
        ),
      ],
    );

    final base = TextStyle(
      fontSize: 16.0 * s,
      height: 1.26,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(8 * s, 6 * s, 6 * s, 2 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Características", style: h),
          SizedBox(height: 12 * s),

          _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: DefaultTextStyle(
              style: base,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Bullet(text: "Escalable: desde una solución integrada en el variador hasta un sistema completo de control de seguridad"),
                  _Bullet(text: "Versátil: el diseño compacto requiere menos espacio en el gabinete de control"),
                  _Bullet(text: "Tiempos de ciclo rápidos como base para tiempos de respuesta rápidos"),
                  _Bullet(text: "Extensión mediante E/S modulares sobre FSoE"),
                  _Bullet(text: "Ingeniería eficiente gracias a la programación gráfica"),
                ],
              ),
            ),
          ),

          SizedBox(height: 14 * s),

          // ✅ SOLO UNA IMAGEN ABAJO
          Expanded(
            child: _InnerGlassPanel(
              s: s,
              padding: EdgeInsets.all(10 * s),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18 * s),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: _FitImageToCardGlass(
                        s: s,
                        asset: img,
                        topInset: 0,
                        sideInset: 0,
                        bottomInset: 0,
                        blurOpacity: 0.10,
                        overlayOpacity: 0.08,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18 * s),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.12),
                            width: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== CARD 2 =====================

class _Card2Content extends StatelessWidget {
  final double s;
  const _Card2Content({required this.s});

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: 16.0 * s,
      height: 1.30,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    final strong = base.copyWith(fontWeight: FontWeight.w900, color: Colors.white.withOpacity(0.95));

    return Padding(
      padding: EdgeInsets.fromLTRB(10 * s, 10 * s, 8 * s, 6 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: RichText(
              text: TextSpan(
                style: base,
                children: [
                  TextSpan(text: "SafeLogic", style: strong),
                  const TextSpan(text: " se refiere a la "),
                  TextSpan(text: "lógica de control de seguridad", style: strong),
                  const TextSpan(text: ". Es un PLC dedicado exclusivamente a procesar señales críticas (como paradas de emergencia, cortinas de luz o sensores de puertas) y decidir qué acción de seguridad tomar."),
                ],
              ),
            ),
          ),

          SizedBox(height: 14 * s),

          Expanded(
            child: _InnerGlassPanel(
              s: s,
              padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
              child: DefaultTextStyle(
                style: base,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _BulletRich(
                      head: "Hardware:",
                      body: " Se materializa en controladores compactos como el SAFEX-C.12 o SAFEX-C.15.",
                    ),
                    SizedBox(height: 10),
                    _BulletRich(
                      head: "Programación:",
                      body: " Se realiza mediante un editor gráfico (diagrama de bloques funcionales) pre-certificados. Esto facilita mucho la validación de la máquina.",
                    ),
                    SizedBox(height: 10),
                    _BulletRich(
                      head: "Función principal:",
                      body: " Leer entradas de seguridad, ejecutar una lógica (si A y B están abiertos, entonces detén el motor) y enviar señales de parada.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== CARD 3 =====================

class _Card3Content extends StatelessWidget {
  final double s;
  const _Card3Content({required this.s});

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(
      fontSize: 16.0 * s,
      height: 1.30,
      fontWeight: FontWeight.w700,
      color: Colors.white.withOpacity(0.90),
    );

    final strong = base.copyWith(fontWeight: FontWeight.w900, color: Colors.white.withOpacity(0.95));

    return Padding(
      padding: EdgeInsets.fromLTRB(10 * s, 10 * s, 8 * s, 6 * s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InnerGlassPanel(
            s: s,
            padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
            child: RichText(
              text: TextSpan(
                style: base,
                children: [
                  TextSpan(text: "SafeMotion", style: strong),
                  const TextSpan(text: " es la tecnología que permite que el propio regulador (el "),
                  TextSpan(text: "ctrlX DRIVE", style: strong),
                  const TextSpan(text: ") gestione funciones de seguridad avanzadas sin necesidad de cortar la energía de golpe.\n\n"),
                  TextSpan(text: "Ubicación:", style: strong),
                  const TextSpan(text: " Vive dentro del hardware del drive (accionamiento).\n"),
                  TextSpan(text: "Funciones clave:", style: strong),
                ],
              ),
            ),
          ),

          SizedBox(height: 14 * s),

          Expanded(
            child: _InnerGlassPanel(
              s: s,
              padding: EdgeInsets.fromLTRB(14 * s, 12 * s, 14 * s, 12 * s),
              child: DefaultTextStyle(
                style: base,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _MiniDot(head: "STO (Safe Torque Off):", body: " Corta el par del motor (función básica)."),
                    SizedBox(height: 10 * s),
                    const _MiniDot(head: "SLS (Safely Limited Speed):", body: " Permite que el motor se mueva, pero garantiza que no supere una velocidad segura (útil para mantenimiento con puertas abiertas)."),
                    SizedBox(height: 10 * s),
                    const _MiniDot(head: "SOS (Safe Operating Stop):", body: " Mantiene el motor en posición con par, pero vigilando que no se mueva."),
                    SizedBox(height: 14 * s),
                    RichText(
                      text: TextSpan(
                        style: base,
                        children: [
                          TextSpan(text: "Ventaja:", style: strong),
                          const TextSpan(text: " Al estar en el drive, la respuesta es mucho más rápida que si la señal tuviera que viajar por todo el bus de comunicación estándar."),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== BULLETS =====================

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.92);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 6.2,
              height: 6.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2EC4FF).withOpacity(0.82),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.18),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletRich extends StatelessWidget {
  final String head;
  final String body;
  const _BulletRich({required this.head, required this.body});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.92);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 6.2,
            height: 6.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2EC4FF).withOpacity(0.82),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.18),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.30,
                color: textColor,
              ),
              children: [
                TextSpan(text: head, style: TextStyle(fontWeight: FontWeight.w900, color: textColor)),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniDot extends StatelessWidget {
  final String head;
  final String body;
  const _MiniDot({required this.head, required this.body});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.white.withOpacity(0.92);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Container(
            width: 6.0,
            height: 6.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2EC4FF).withOpacity(0.82),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                  color: Colors.black.withOpacity(0.18),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.w700,
                height: 1.30,
                color: textColor,
              ),
              children: [
                TextSpan(text: head, style: TextStyle(fontWeight: FontWeight.w900, color: textColor)),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
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
          padding: EdgeInsets.symmetric(horizontal: 22 * scale, vertical: 14 * scale),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18 * scale),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.6),
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
                    height: 1.02,
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
            color: Colors.white.withOpacity(0.09),
            borderRadius: BorderRadius.circular(r),
            border: Border.all(color: Colors.white.withOpacity(0.14), width: 1.8),
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
                        Colors.white.withOpacity(0.11),
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

// ===================== INNER GLASS PANEL =====================

class _InnerGlassPanel extends StatelessWidget {
  final double s;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _InnerGlassPanel({
    required this.s,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(22 * s),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22 * s),
            color: Colors.white.withOpacity(0.06),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ===================== IMAGE FIT (GLASS) =====================

class _FitImageToCardGlass extends StatelessWidget {
  final double s;
  final String asset;
  final double topInset;
  final double sideInset;
  final double bottomInset;
  final double blurOpacity;
  final double overlayOpacity;
  final BoxFit fit;

  const _FitImageToCardGlass({
    required this.s,
    required this.asset,
    this.topInset = 10,
    this.sideInset = 10,
    this.bottomInset = 10,
    this.blurOpacity = 0.12,
    this.overlayOpacity = 0.05,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    Widget fallback() => _ImageFallbackGlass(s: s);

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
        Positioned.fill(child: Container(color: Colors.black.withOpacity(overlayOpacity))),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.fromLTRB(sideInset, topInset, sideInset, bottomInset),
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

class _ImageFallbackGlass extends StatelessWidget {
  final double s;
  const _ImageFallbackGlass({required this.s});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.04),
      child: Center(
        child: Icon(
          Icons.image_rounded,
          size: 74 * s,
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
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  const Color(0xFF2EC4FF).withOpacity(0.14),
                  Colors.black.withOpacity(0.28),
                  const Color(0xFFFF2B2B).withOpacity(0.12),
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
                  Colors.black.withOpacity(0.16),
                  Colors.black.withOpacity(0.60),
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
  bool shouldRepaint(covariant _GridPainter oldDelegate) => oldDelegate.step != step;
}
