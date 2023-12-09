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
  int _health = 3;

  double get heat => _heat;
  void set heat(double currentheat) {
    _heat = currentheat;
    debugText.text =
        'Heat: ' + _heat.toString() + ' Health: ' + _health.toString();
    player.egg.setState(Health: _health, heat: _heat);
  }

  int get health => _health;
  void set health(int currentHealth) {
    print(currentHealth);
    _health = currentHealth;
    debugText.text =
        'Heat: ' + _heat.toString() + ' Health: ' + _health.toString();
    player.egg.setState(Health: _health, heat: _heat);
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    player = Player();
    debugText = TextComponent(
        text: 'Heat: ' + _heat.toString() + ' Health: ' + _health.toString());

    add(BackgroundHolder());

    add(player);
    add(
      PowerUpSpawner(
        textureHeight: 151,
        textureWidth: 151,
      ),
    );

    add(debugText);

    // debugMode = true;
    // add(Egg());

    // final sprite = await loadSprite('power_ups/ice_cube.png');
    // add(
    //   SpriteComponent(
    //     sprite: sprite,
    //     position: size / 2,
    //     size: sprite.srcSize * 2,
    //     anchor: Anchor.center,
    //   ),
    // );
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
