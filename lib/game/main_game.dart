import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incubation_odyssey/game/background/background.dart';
import 'package:incubation_odyssey/game/player/player.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/power_ups/power_up_spawner.dart';
import 'package:incubation_odyssey/game/screens/gameover_screen.dart';
import 'package:incubation_odyssey/game/screens/pause_screen.dart';
import 'package:incubation_odyssey/game/screens/win_screen.dart';
import 'package:incubation_odyssey/game/variables.dart';

class MainGame extends FlameGame with HasCollisionDetection, KeyboardEvents {
  late ValueNotifier<bool> gameStartedNotifier;

  MainGame(
      {required ValueNotifier<bool> gameStartValueNotifier}) {
    gameStartedNotifier = gameStartValueNotifier;
  }

  late Player player;
  late TextComponent debugText;
  late BackgroundHolder backgroundHolder;
  // late AudioPlayer _audioPlayer;
  final ValueNotifier<double> heatNotifier = ValueNotifier<double>(0.0);
  late AudioPlayer _audioPlayer;
  int _health = 3;

  late Timer _dashTimer;
  late Timer _dashCooldownTimer;
  bool _dashReady = true;

  double get heat => heatNotifier.value;
  set heat(double currentheat) {
    heatNotifier.value = currentheat;
    debugText.text = 'Heat: ${heatNotifier.value} Health: $_health';
    player.setState(health: _health, heat: heatNotifier.value);
  }

  int get health => _health;
  set health(int currentHealth) {
    _health = currentHealth;
    debugText.text = 'Heat: ${heatNotifier.value} Health: $_health';
    player.setState(health: _health, heat: heatNotifier.value);
  }

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    //   _audioPlayer = await FlameAudio.loop('Mx_Title.wav');

    // camera.viewport = FixedResolutionViewport(resolution: Vector2(1920, 1080));
    camera = CameraComponent.withFixedResolution(width: 1920, height: 1080);

    player = Player();
    _dashTimer = Timer(Variables.dashDuration, onTick: () {
      player.stopDash();
      setPlayerSpeed(Variables.playerBaseSpeed);
    });
    _dashCooldownTimer = Timer(Variables.dashCooldown, onTick: () {
      _dashReady = true;
    });

    debugText =
        TextComponent(text: 'Heat: ${heatNotifier.value} Health: $_health');

    backgroundHolder = BackgroundHolder();
    add(backgroundHolder);

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
    PowerUp test = PowerUp(powerUpType: PowerUpType.spike);
    test.x = 200;
    test.y = 200;
    add(test);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isZ = keysPressed.contains(LogicalKeyboardKey.keyZ);
    final isX = keysPressed.contains(LogicalKeyboardKey.keyX);
    final isKeyDown = event is RawKeyDownEvent;

    if (isX && isKeyDown) {
      dash();
      return KeyEventResult.handled;
    } else if (isZ && isKeyDown) {
      player.jump();
      return KeyEventResult.handled;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _dashTimer.update(dt);
    _dashCooldownTimer.update(dt);
  }

  Future<void> pauseGame() async {
    overlays.add(PauseScreen.id);
    pauseEngine();
  }

  Future<void> resetGame() async {
    overlays.clear();
    health = 3;
    heat = 0;
    player.current = EggState.chicken;
    resumeEngine();
  }

  Future<void> startGame() async {
    /// _audioPlayer.stop();
    // _audioPlayer = await FlameAudio.loop('Mx_Gameplay.wav');
    gameStartedNotifier.value = true;
  }

  Future<void> gameOver() async {
    //TODO: _audioPlayer.stop();
    //TODO: _audioPlayer = await FlameAudio.loop('Mx_GameOver.wav');
    overlays.add(GameOverScreen.id);
    pauseEngine();
  }

  Future<void> winGame() async {
    pauseEngine();
    //TODO: _audioPlayer.stop();
    //TODO: _audioPlayer = await FlameAudio.loop('Mx_Win.wav');
    overlays.add(WinScreen.id);
  }

  void setPlayerSpeed(double speed) {
    // children.whereType<PowerUp>().forEach((powerUp) {
    //   powerUp.speed = Variables.powerUpSpeed + speed;
    // });

    PowerUp.speed = Variables.powerUpSpeed + speed;

    Variables.playerSpeed = speed;

    backgroundHolder.background.parallax?.baseVelocity =
        Vector2(Variables.playerSpeed, 0);
  }

  void dash() {
    if (_dashReady) {
      player.dash();
      setPlayerSpeed(Variables.playerBaseSpeed + Variables.dashSpeed);
      _dashTimer.start();
      _dashReady = false;
      _dashCooldownTimer.start();
    }
  }
}
