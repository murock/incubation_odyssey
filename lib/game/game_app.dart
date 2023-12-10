import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/screens/gameover_screen.dart';
import 'package:incubation_odyssey/game/screens/instructions_screen.dart';
import 'package:incubation_odyssey/game/screens/main_menu_screen.dart';
import 'package:incubation_odyssey/game/screens/pause_screen.dart';
import 'package:incubation_odyssey/game/screens/win_screen.dart';
import 'package:incubation_odyssey/game/theme/game_theme.dart';
import 'package:incubation_odyssey/game/widgets/temperature_bar.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  final ValueNotifier<bool> gameStartedNotifier = ValueNotifier<bool>(false);
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    FlameAudio.bgm.initialize();
    startMusic();
  }

  startMusic() async {
    _audioPlayer = await FlameAudio.loop('Mx_Title.wav');
  }

  @override
  Widget build(BuildContext context) {
    final game = MainGame(
      gameStartValueNotifier: gameStartedNotifier,
    );

    return Stack(
      children: [
        GameWidget(
          game: game,
          initialActiveOverlays: const [MainMenuScreen.id],
          overlayBuilderMap: {
            'mainmenu': (context, _) => MainMenuScreen(game: game),
            'pause': (context, _) => PauseScreen(game: game),
            'gameover': (context, _) => GameOverScreen(game: game),
            'win': (context, _) => WinScreen(game: game),
            'instructions': (context, _) => InstructionsScreen(game: game),
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
                  valueListenable: game.heatNotifier,
                  builder: (context, temperature, child) {
                    return TemperatureBar(temperature: temperature);
                  },
                ),
              );
            }),
        ValueListenableBuilder<bool>(
            valueListenable: gameStartedNotifier,
            builder: (context, gameStarted, child) {
              if (!gameStarted) {
                return const SizedBox.shrink();
              }
              return Positioned(
                top: 30,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    game.paused ? Icons.play_arrow : Icons.pause,
                    size: 80,
                    color: GameTheme.brown,
                  ),
                  onPressed: () {
                    game.pauseGame();
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
    _audioPlayer.dispose();
    super.dispose();
  }
}
