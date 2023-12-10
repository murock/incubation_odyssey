import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';

import '../player/player.dart';

class WinScreen extends StatelessWidget {
  final MainGame game;
  static const String id = 'win';

  const WinScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Hatch Hatch!!',
                style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'SamuraiBlast')),
            const SizedBox(height: 20),
            Text(
                'You Successfully Hatched A ${getHatchedSpecies(game.player.current)}!!',
                style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontFamily: 'SinglyLinked')),
            const SizedBox(height: 20),
            Text('Temperature: ${game.heat}',
                style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontFamily: 'SinglyLinked')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Set corner radius to 2
                ),
              ),
              child: const Text(
                'Play Again',
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

  String getHatchedSpecies(current) {
    switch (current) {
      case EggState.chickenHatched:
        return 'Chicken';
      case EggState.penguinHatched:
        return 'Penguin';
      case EggState.dragonHatched:
        return 'Dragon';
      case EggState.wyvernHatched:
        return 'Wyvern';
      case EggState.lizardHatched:
        return 'Lizard';
      default:
        return '';
    }
  }

  void onRestart() {
    game.resetGame();
  }
}
