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
            const Text('Game Over!',
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'SamuraiBlast')),
            const SizedBox(height: 20),
            Text(
                'Hearts Remaining: ${game.health}',
                style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'SinglyLinked'
                )
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
                'Restart',
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
    game.startGame();
    game.overlays.remove('gameover');
    game.resumeEngine();
  }
}