import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum PowerUpType {
  iceCube,
  fire,
  spike,
}

class PowerUpData {
  PowerUpData({required this.srcLoc, required this.size});
  final String srcLoc;
  final Vector2 size;
}

class PowerUp extends SpriteAnimationComponent with HasGameRef {
  PowerUp({
    required this.numFrames,
    required this.powerUpType,
  });

  final int numFrames;
  final PowerUpType powerUpType;

  final Map<PowerUpType, PowerUpData> imageSourceMap = {
    PowerUpType.iceCube:
        PowerUpData(srcLoc: 'power_ups/ice_cube.png', size: Vector2(151, 151)),
    PowerUpType.fire:
        PowerUpData(srcLoc: 'power_ups/fire.png', size: Vector2(98, 76)),
    PowerUpType.spike:
        PowerUpData(srcLoc: 'power_ups/spike.png', size: Vector2(151, 151)),
  };

  static double _speed = Variables.powerUpSpeed + Variables.playerBaseSpeed;

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
