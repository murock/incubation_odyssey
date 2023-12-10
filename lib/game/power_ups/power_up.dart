import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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
    this.srcPos,
  });
  final String srcLoc;
  final Vector2 size;
  final Vector2? srcPos;
}

class PowerUp extends SpriteAnimationComponent with HasGameRef {
  PowerUp({
    required this.numFrames,
    required this.powerUpType,
  });

  final int numFrames;
  final PowerUpType powerUpType;

  final Map<PowerUpType, PowerUpData> imageSourceMap = {
    PowerUpType.fire: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 0),
    ),
    PowerUpType.coal: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 100),
    ),
    PowerUpType.heatwave: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(0, 200),
    ),
    PowerUpType.snowflake: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 0),
    ),
    PowerUpType.water: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 100),
    ),
    PowerUpType.iceCube: PowerUpData(
      srcLoc: 'power_ups/power_up_sprite_sheet.png',
      size: Vector2(100, 100),
      srcPos: Vector2(100, 200),
    ),
    PowerUpType.spike:
        PowerUpData(srcLoc: 'power_ups/spike.png', size: Vector2(151, 151)),
  };

  static double _speed = Variables.powerUpSpeed + Variables.playerBaseSpeed;
  set speed(double speed) {
    _speed = speed;
  }

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
        amount: numFrames,
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

    x -= _speed * dt;
    y = Variables.powerUpPathAmplitude * sin(0.01 * x) +
        Variables.powerUpHeight;
    if (x < 0 - size.x) removeFromParent();
  }
}
