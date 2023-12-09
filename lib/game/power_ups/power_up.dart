import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/variables.dart';

class PowerUp extends SpriteAnimationComponent with HasGameRef {
  PowerUp({required this.numFrames, required this.textureSize});

  final int numFrames;
  final Vector2 textureSize;

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
      'power_ups/ice_cube.png',
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
