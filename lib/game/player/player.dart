import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/animations/egg_component.dart';
import 'package:incubation_odyssey/game/main_game.dart';
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

  @override
  FutureOr<void> onLoad() async {
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
    scale = Vector2.all(20);
    current = PlayerState.idle;
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

  void jump() {
    if (_isOnGround()) {
      _speedY = -Variables.jumpForce;
    }
  }

  bool _isOnGround() {
    return y >= _yMax;
  }
}
