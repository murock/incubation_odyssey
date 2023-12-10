import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum PowerUpType {
  fire,
  coal,
  heatwave,
  snowflake,
  water,
  iceCube,
  spike,
}

class PowerUpData {
  PowerUpData({
    required this.srcLoc,
    required this.size,
    required this.movementCallback,
    this.numFrames = 1,
    this.srcPos,
  });
  final String srcLoc;
  final Vector2 size;
  final int numFrames;
  final Vector2? srcPos;
  final double Function({required double elapsedTime}) movementCallback;
}

class PowerUp extends SpriteAnimationComponent with HasGameRef<MainGame> {
  PowerUp({
    required this.powerUpType,
  });

  final PowerUpType powerUpType;

  double? straightMovementHeight;

  double elapsedTime = 0;

  final Map<PowerUpType, PowerUpData> imageSourceMap = {
    PowerUpType.fire: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 0),
      movementCallback: _straightMovement,
    ),
    PowerUpType.coal: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 100),
      movementCallback: _fallingMovement,
    ),
    PowerUpType.heatwave: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 200),
      movementCallback: _waveMovement,
    ),
    PowerUpType.snowflake: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 0),
      movementCallback: _waveMovement,
    ),
    PowerUpType.water: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 100),
      movementCallback: _fallingMovement,
    ),
    PowerUpType.iceCube: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 200),
      movementCallback: _fallingMovement,
    ),
    PowerUpType.spike: PowerUpData(
      srcLoc: 'power_ups/spike.png',
      size: Vector2(200, 200),
      movementCallback: _straightMovement,
      numFrames: 2,
    ),
  };

  static double speed = Variables.powerUpSpeed + Variables.playerBaseSpeed;
  // set speed(double speed) {
  //   _speed = speed;
  // }

  @override
  FutureOr<void> onLoad() {
    x = 1920;
    _setupHitbox();
    _setupAnimation();
    return super.onLoad();
  }

  void _setupHitbox() {
    RectangleHitbox hitbox = RectangleHitbox();
    hitbox.collisionType = CollisionType.passive;
    add(hitbox);
  }

  Future<void> _setupAnimation() async {
    animation = await SpriteAnimation.load(
      imageSourceMap[powerUpType]!.srcLoc,
      SpriteAnimationData.sequenced(
        amount: imageSourceMap[powerUpType]!.numFrames,
        amountPerRow: 1,
        stepTime: 0.1,
        textureSize: imageSourceMap[powerUpType]!.size,
        texturePosition: imageSourceMap[powerUpType]?.srcPos != null
            ? imageSourceMap[powerUpType]!.srcPos!
            : null,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt * Variables.powerUpSpeed;

    x -= speed * dt;
    y = (powerUpType == PowerUpType.fire || powerUpType == PowerUpType.spike)
        ? powerUpHeight
        : imageSourceMap[powerUpType]!
            .movementCallback(elapsedTime: elapsedTime);
    // Variables.powerUpPathAmplitude * sin(0.01 * elapsedTime) +
    //     Variables.powerUpHeight;
    if (x < 0 - size.x) removeFromParent();
  }

  double get powerUpHeight {
    straightMovementHeight ??= _straightMovement(elapsedTime: 0);
    return straightMovementHeight!;
  }

  static double _waveMovement({required double elapsedTime}) {
    return Variables.powerUpPathAmplitude * sin(0.01 * elapsedTime) +
        Variables.powerUpHeight;
  }

  static double _straightMovement({required double elapsedTime}) {
    var intValue = Random().nextDouble() * (Variables.yMax - Variables.yMin) +
        Variables.yMin;
    return intValue;
  }

  static double _fallingMovement({required double elapsedTime}) {
    return elapsedTime;
  }
}
