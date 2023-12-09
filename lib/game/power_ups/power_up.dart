import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum PowerUpType {
  iceCube,
  fire,
}

class PowerUp extends SpriteAnimationComponent with HasGameRef {
  PowerUp({
    required this.numFrames,
    required this.textureSize,
    required this.powerUpType,
  });

  final int numFrames;
  final Vector2 textureSize;
  final PowerUpType powerUpType;

  final Map<PowerUpType, String> imageSourceMap = {
    PowerUpType.iceCube: 'power_ups/ice_cube.png',
    PowerUpType.fire: 'power_ups/fire.png',
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
      imageSourceMap[powerUpType]!,
      SpriteAnimationData.sequenced(
        amount: numFrames,
        stepTime: 0.1,
        textureSize: textureSize,
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
