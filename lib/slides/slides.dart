import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slide_01.dart';
import 'slide_02.dart';
import 'slide_3.dart';
import 'slide_04.dart';
import 'slide_05.dart';
import 'slide_06.dart';
import 'slide_07.dart';
import 'slide_08.dart';
import 'slide_09.dart';
import 'slide_10.dart';
import 'slide_11.dart';
import 'slide_12.dart';
import 'slide_13.dart';
import 'slide_14.dart';
import 'slide_15.dart';
import 'slide_16.dart';
import 'slide_17.dart';
import 'slide_18.dart';
import 'slide_19.dart';
import 'slide_20.dart';

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
    Slide03(),
    Slide04(),
    Slide05(),
    Slide06(),
    Slide07(),
    Slide08(),
    Slide09(),
    Slide10(),
    Slide11(),
    Slide12(),
    Slide13(),
    Slide14(),
    Slide15(),
    Slide16(),
    Slide17(),
    Slide18(),
    Slide19(),
    Slide20(),

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
                    color: Color.fromARGB(137, 0, 0, 0),
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
