import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/player/egg.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum PlayerState {
  idle,
  heating,
}

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  double _speedY = 0.0;
  final double _yMax = 700;
  bool _isJumping = false;
  late Egg egg;

  @override
  FutureOr<void> onLoad() async {
    RectangleHitbox hitbox = RectangleHitbox();
    add(hitbox);

    final SpriteAnimation idle = await game.loadSpriteAnimation(
      'egg_sprite_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(27, 24),
      ),
    );

    animations = {
      PlayerState.idle: idle,
    };
    scale = Vector2.all(Variables.gameScale);
    current = PlayerState.idle;

    egg = Egg();
    egg.parent = this;
    add(egg);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _speedY += Variables.gravity * dt;
    y += _speedY * dt;

    if (_isOnGround()) {
      if (_isJumping) {
        _isJumping = false;
      }
      y = _yMax;
      _speedY = 0.0;
    } else if (!_isJumping) {
      _isJumping = true;
    }

    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PowerUp) {
      final PowerUp powerUp = other;
      if (powerUp.powerUpType == PowerUpType.iceCube) {
        game.heat -= 10;
        other.removeFromParent();
      }
      if (powerUp.powerUpType == PowerUpType.fire) {
        game.heat += 10;
        other.removeFromParent();
      }
    }
  }

  void jump() {
    if (_isOnGround()) {
      _speedY = -Variables.jumpForce;
    }
  }

  bool _isOnGround() {
    return y >= _yMax;
  }
}
