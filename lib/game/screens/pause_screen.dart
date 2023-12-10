import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/screens/main_menu_screen.dart';
import 'package:incubation_odyssey/game/theme/game_theme.dart';

import 'instructions_screen.dart';

class PauseScreen extends StatelessWidget {
  final MainGame game;
  static const String id = 'pause';

  const PauseScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Paused',
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'SamuraiBlast')),
            const SizedBox(height: 20),
            IconButton(
              icon: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("instructions",
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'SinglyLinked',
                          color: GameTheme.blue,
                        )),
                    Icon(
                      Icons.integration_instructions_outlined,
                      size: 60,
                      color: GameTheme.blue,
                    ),
                  ]),
              onPressed: () {
                game.overlays.add(InstructionsScreen.id);
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("exit",
                        style: TextStyle(
                          fontSize: 34,
                          fontFamily: 'SinglyLinked',
                          color: GameTheme.blue,
                        )),
                    Icon(
                      Icons.exit_to_app,
                      size: 60,
                      color: GameTheme.blue,
                    ),
                  ]),
              onPressed: () {
                game.overlays.add(MainMenuScreen.id);
                game.gameStartedNotifier.value = false;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Set corner radius to 2
                ),
              ),
              child: const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SinglyLinked',
                  color: Colors.white, // Set text color to white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.overlays.remove('pause');
    game.resumeEngine();
  }
}