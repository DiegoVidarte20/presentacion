import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slide_01.dart';
import 'slide_02.dart';
import 'slide_11.dart';
import 'slide_12.dart';
import 'slide_13.dart';

class Slides extends StatefulWidget {
  const Slides({super.key});

  @override
  State<Slides> createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  int _index = 0;

  // Lista de tus slides (agrega más acá)
  late final List<Widget> _slides = const [
    Slide01(),
    Slide02(),
    Slide11(),
    Slide12(),
    Slide13(),
  ];

  int get _total => _slides.length;

  void _next() {
    setState(() => _index = (_index + 1).clamp(0, _total - 1));
  }

  void _prev() {
    setState(() => _index = (_index - 1).clamp(0, _total - 1));
  }

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    if (event is! RawKeyDownEvent) return KeyEventResult.ignored;

    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowRight ||
        key == LogicalKeyboardKey.pageDown ||
        key == LogicalKeyboardKey.space) {
      _next();
      return KeyEventResult.handled;
    }

    if (key == LogicalKeyboardKey.arrowLeft ||
        key == LogicalKeyboardKey.pageUp) {
      _prev();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        onKey: _onKey,
        child: GestureDetector(
          // opcional: click/tap para avanzar
          onTap: _next,
          // opcional: swipe para móvil
          onHorizontalDragEnd: (d) {
            if ((d.primaryVelocity ?? 0) < 0) _next(); // swipe izquierda
            if ((d.primaryVelocity ?? 0) > 0) _prev(); // swipe derecha
          },
          child: Stack(
            children: [
              // Transición suave entre slides
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: SizedBox.expand(
                  key: ValueKey(_index),
                  child: _slides[_index],
                ),
              ),

              // Indicador simple (si no quieres, bórralo)
              Positioned(
                left: 18,
                bottom: 12,
                child: Text(
                  '${_index + 1}/$_total',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
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
