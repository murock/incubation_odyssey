import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/screens/game_screen.dart';
import 'package:incubation_odyssey/game/screens/main_menu_screen.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
    final game = MainGame();
    return GameWidget(
      game: game,
      initialActiveOverlays: const [MainMenuScreen.id],
      overlayBuilderMap: {
        'mainmenu': (context, _) => MainMenuScreen(game: game),
        'gameover': (context, _) => GameOverScreen(game: game)
      },
    );
  }
}
