import 'package:flutter/material.dart';
import 'ui/shell.dart';
import 'slides/slide_01.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SlideShell(
        index: 1,
        total: 49,
        child: Slide01(),
      ),
    );
  }
}
