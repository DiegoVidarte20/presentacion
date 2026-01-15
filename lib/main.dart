import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'slides/slides.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // video_player_media_kit
  VideoPlayerMediaKit.ensureInitialized(windows: true);

  // window_manager
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1920, 1080),          // 👈 ventana grande (cámbialo a 1920x1080 si quieres)
    minimumSize: Size(1280, 720),   // 👈 para que no lo achiquen demasiado
    center: true,
    title: 'Presentacion',
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.maximize();
    await windowManager.focus();
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Slides(),
    );
  }
}
