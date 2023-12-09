import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubation_odyssey/game/background/background.dart';
import 'package:incubation_odyssey/game/player/egg.dart';
import 'package:incubation_odyssey/game/player/player.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/power_ups/power_up_spawner.dart';

class MainGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late Player player;
  late TextComponent debugText;
  double _heat = 0;

  double get heat => _heat;
  void set heat(double currentheat) {
    _heat = currentheat;
    debugText.text = 'Heat: ' + _heat.toString();
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // debugMode = true;

    player = Player();
    debugText = TextComponent(text: 'Heat: ' + _heat.toString());

    add(BackgroundHolder());

    add(player);
    //add(PowerUp(numFrames: 1, textureSize: Vector2(151, 151)));
    add(PowerUpSpawner());
    // add(Egg());

    add(debugText);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isZ = keysPressed.contains(LogicalKeyboardKey.keyZ);
    final isKeyDown = event is RawKeyDownEvent;
    // TODO: implement onKeyEvent
    if (isZ && isKeyDown) {
      player.jump();
      return KeyEventResult.handled;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}
