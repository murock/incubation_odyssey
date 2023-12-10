import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';

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