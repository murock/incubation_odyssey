import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';

class GameOverScreen extends StatelessWidget {
  final MainGame game;
  static const String id = 'gameover';

  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Heat: ${game.heat}',
                style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'Game'
                )
            ),
            Image.asset("gameover.png"),
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
                'Restart',
                style: TextStyle(
                  fontSize: 20,
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
    //TODO: reset game
    game.overlays.remove('gameover');
    game.resumeEngine();
  }
}