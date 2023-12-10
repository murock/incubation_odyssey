import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubation_odyssey/game/background/background.dart';
import 'package:incubation_odyssey/game/player/player.dart';
import 'package:incubation_odyssey/game/power_ups/power_up_spawner.dart';

class MainGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late Player player;
  late TextComponent debugText;
  late AudioPlayer _audioPlayer;
  final ValueNotifier<double> heatNotifier = ValueNotifier<double>(0.0);
  int _health = 3;

  double get heat => heatNotifier.value;
  set heat(double currentheat) {
    heatNotifier.value = currentheat;
    debugText.text = 'Heat: ${heatNotifier.value} Health: $_health';
    player.egg.setState(health: _health, heat: heatNotifier.value);
  }

  int get health => _health;
  set health(int currentHealth) {
    _health = currentHealth;
    debugText.text = 'Heat: ${heatNotifier.value} Health: $_health';
    player.egg.setState(health: _health, heat: heatNotifier.value);
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    _audioPlayer = await FlameAudio.loop('Mx_Title.wav');

    camera.viewport = FixedResolutionViewport(resolution: Vector2(1920, 1080));

    player = Player();
    debugText =
        TextComponent(text: 'Heat: ${heatNotifier.value} Health: $_health');

    add(BackgroundHolder());

    add(player);
    add(
      PowerUpSpawner(
        textureHeight: 151,
        textureWidth: 151,
      ),
    );

    add(debugText);

    //debugMode = true;
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
    if (isZ && isKeyDown) {
      player.jump();
      return KeyEventResult.handled;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  Future<void> startGame() async {
    _audioPlayer.stop();
    _audioPlayer = await FlameAudio.play('Mx_Gameplay.wav');
  }
}
