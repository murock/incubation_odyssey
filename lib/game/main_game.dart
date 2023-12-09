import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubation_odyssey/game/background/background.dart';
import 'package:incubation_odyssey/game/player/player.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';

class MainGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late Player player;

  @override
  Color backgroundColor() => Colors.purple;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    player = Player();

    add(BackgroundHolder());
    add(player);
    add(PowerUp(numFrames: 1, textureSize: Vector2(151, 151)));
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
