import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/screens/game_screen.dart';
import 'package:incubation_odyssey/game/screens/main_menu_screen.dart';
import 'package:incubation_odyssey/game/widgets/temperature_bar.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  final ValueNotifier<double> heatNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> gameStartedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final game = MainGame(
      temperatureValueNotifier: heatNotifier,
      gameStartValueNotifier: gameStartedNotifier,
    );

    return Stack(
      children: [
        GameWidget(
          game: game,
          initialActiveOverlays: const [MainMenuScreen.id],
          overlayBuilderMap: {
            'mainmenu': (context, _) => MainMenuScreen(game: game),
            'gameover': (context, _) => GameOverScreen(game: game),
          },
        ),
        ValueListenableBuilder<bool>(
            valueListenable: gameStartedNotifier,
            builder: (context, gameStarted, child) {
              if (!gameStarted) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 30,
                left: 10,
                child: ValueListenableBuilder<double>(
                  valueListenable: heatNotifier,
                  builder: (context, temperature, child) {
                    return TemperatureBar(temperature: temperature);
                  },
                ),
              );
            }),
      ],
    );
  }

  @override
  void dispose() {
    gameStartedNotifier.dispose();
    heatNotifier.dispose();
    super.dispose();
  }
}
