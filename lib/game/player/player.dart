import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/effects.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/player/balloon.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/theme/game_theme.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum EggState {
  wyvern,
  wyvernDamaged1,
  wyvernDamaged2,
  wyvernHatched,
  penguin,
  penguinDamaged1,
  penguinDamaged2,
  penguinHatched,
  chicken,
  chickenDamaged1,
  chickenDamaged2,
  chickenHatched,
  lizard,
  lizardDamaged1,
  lizardDamaged2,
  lizardHatched,
  dragon,
  dragonDamaged1,
  dragonDamaged2,
  dragonHatched,
}

class Player extends SpriteGroupComponent
    with HasGameRef<MainGame>, CollisionCallbacks {
  final double textureWidth = 43;
  final double textureHeight = 60;
  final double margin = 2;
  late Balloon balloon;

  double _speedY = 0.0;
  final double yMax = Variables.yMax;
  final double yMin = Variables.yMin;
  bool _isJumping = false;

  @override
  FutureOr<void> onLoad() async {
    scale = Vector2.all(1.5);
    y = 250;
    x = 200;

    balloon = Balloon();
    add(balloon);
    balloon.x = -55;
    balloon.y = -100;

    RectangleHitbox hitbox = RectangleHitbox();
    add(hitbox);

    final double damaged1Pos = textureHeight;
    final double damaged2Pos = textureHeight * 2;
    final double hatchedPos = textureHeight * 3;

    final double penguinXPos = textureWidth + margin;
    final double wyvernXPos = textureWidth * 2 + margin;
    final double lizardXPos = textureWidth * 3 + margin;
    final double dragonXPos = textureWidth * 4 + margin;
    sprites = {
      EggState.chicken: await _getSprite(srcPosition: Vector2(margin, 0)),
      EggState.chickenDamaged1:
          await _getSprite(srcPosition: Vector2(margin, damaged1Pos)),
      EggState.chickenDamaged2:
          await _getSprite(srcPosition: Vector2(margin, damaged2Pos)),
      EggState.chickenHatched:
          await _getSprite(srcPosition: Vector2(margin, hatchedPos)),
      EggState.penguin: await _getSprite(srcPosition: Vector2(penguinXPos, 0)),
      EggState.penguinDamaged1:
          await _getSprite(srcPosition: Vector2(penguinXPos, damaged1Pos)),
      EggState.penguinDamaged2:
          await _getSprite(srcPosition: Vector2(penguinXPos, damaged2Pos)),
      EggState.penguinHatched:
          await _getSprite(srcPosition: Vector2(penguinXPos, hatchedPos)),
      EggState.wyvern: await _getSprite(srcPosition: Vector2(wyvernXPos, 0)),
      EggState.wyvernDamaged1:
          await _getSprite(srcPosition: Vector2(wyvernXPos, damaged1Pos)),
      EggState.wyvernDamaged2:
          await _getSprite(srcPosition: Vector2(wyvernXPos, damaged2Pos)),
      EggState.wyvernHatched:
          await _getSprite(srcPosition: Vector2(wyvernXPos, hatchedPos)),
      EggState.lizard: await _getSprite(srcPosition: Vector2(lizardXPos, 0)),
      EggState.lizardDamaged1:
          await _getSprite(srcPosition: Vector2(lizardXPos, damaged1Pos)),
      EggState.lizardDamaged2:
          await _getSprite(srcPosition: Vector2(lizardXPos, damaged2Pos)),
      EggState.lizardHatched:
          await _getSprite(srcPosition: Vector2(lizardXPos, hatchedPos)),
      EggState.dragon: await _getSprite(srcPosition: Vector2(dragonXPos, 0)),
      EggState.dragonDamaged1:
          await _getSprite(srcPosition: Vector2(dragonXPos, damaged1Pos)),
      EggState.dragonDamaged2:
          await _getSprite(srcPosition: Vector2(dragonXPos, damaged2Pos)),
      EggState.dragonHatched:
          await _getSprite(srcPosition: Vector2(dragonXPos, hatchedPos)),
    };
    current = EggState.chicken;
    // x = 800;
    // y = 900;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _speedY += Variables.gravity * dt;
    y += _speedY * dt;

    if (_isOnGround()) {
      jump();
      _takeDamaged();
    } else if (_isOnRoof()) {
      fall();
      _takeDamaged();
    } else if (!_isJumping) {
      _isJumping = true;
    } else if (_speedY > 0) {
      balloon.fall();
    }

    checkGameEnd();

    super.update(dt);
  }

  void dash() {
    angle = 0.4;
  }

  void stopDash() {
    angle = 0;
  }

  void jump() {
    _speedY = -Variables.jumpForce;
    balloon.jump();
  }

  void fall() {
    _speedY = Variables.jumpForce;
  }

  bool _isOnGround() {
    return y >= yMax;
  }

  bool _isOnRoof() {
    return y <= yMin;
  }

  Future<Sprite> _getSprite({required Vector2 srcPosition}) async {
    return await game.loadSprite(
      srcPosition: srcPosition,
      srcSize: Vector2(textureWidth, textureHeight),
      'player/egg_sprite_sheet.png',
    );
  }

  void setState({required int health, required double heat}) {
    print(health);
    print(heat);
    if (heat < Variables.minHeatThreshold &&
        heat > -Variables.minHeatThreshold) {
      if (health == 3) {
        current = EggState.chicken;
      } else if (health == 2) {
        current = EggState.chickenDamaged1;
      } else if (health == 1) {
        current = EggState.chickenDamaged2;
      } else {
        current = EggState.chickenHatched;
      }
    } else if (heat >= Variables.minHeatThreshold &&
        heat < Variables.maxHeatThreshold) {
      if (health == 3) {
        current = EggState.lizard;
      } else if (health == 2) {
        current = EggState.lizardDamaged1;
      } else if (health == 1) {
        current = EggState.lizardDamaged2;
      } else {
        current = EggState.lizardHatched;
      }
    } else if (heat >= Variables.maxHeatThreshold) {
      if (health == 3) {
        current = EggState.dragon;
      } else if (health == 2) {
        current = EggState.dragonDamaged1;
      } else if (health == 1) {
        current = EggState.dragonDamaged2;
      } else {
        current = EggState.dragonHatched;
      }
    } else if (heat <= -Variables.minHeatThreshold &&
        heat > -Variables.maxHeatThreshold) {
      if (health == 3) {
        current = EggState.penguin;
      } else if (health == 2) {
        current = EggState.penguinDamaged1;
      } else if (health == 1) {
        current = EggState.penguinDamaged2;
      } else {
        current = EggState.penguinHatched;
      }
    } else if (heat <= -Variables.maxHeatThreshold) {
      if (health == 3) {
        current = EggState.wyvern;
      } else if (health == 2) {
        current = EggState.wyvernDamaged1;
      } else if (health == 1) {
        current = EggState.wyvernDamaged2;
      } else {
        current = EggState.wyvernHatched;
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is PowerUp) {
      final PowerUp powerUp = other;
      final double intialHeat = game.heat;
      if (powerUp.powerUpType == PowerUpType.fire) {
        game.heat += 30;
        showTemperatureText("+30");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.coal) {
        game.heat += 20;
        showTemperatureText("+20");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.heatwave) {
        game.heat += 10;
        showTemperatureText("+10");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.water) {
        game.heat -= 10;
        showTemperatureText("-10");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.iceCube) {
        game.heat -= 20;
        showTemperatureText("-20");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.snowflake) {
        game.heat -= 30;
        showTemperatureText("-30");
        other.removeFromParent();
      } else if (powerUp.powerUpType == PowerUpType.spike) {
        _takeDamaged();
        other.removeFromParent();
      }

      if (intialHeat > game.heat) {
        FlameAudio.play('Colder.wav');
      } else if (intialHeat < game.heat) {
        FlameAudio.play('Warmer.wav');
      }
    }
  }

  void _takeDamaged() {
    game.health -= 1;
    showTemperatureText("-1");

    FlameAudio.play('ShellCrack.wav');
  }

  void showTemperatureText(String temperature) {
    final text = TextComponent(
      priority: 3,
      position: Vector2(position.x + size.x / 2, position.y + 40),
      anchor: Anchor.center,
      text: temperature,
      textRenderer: GameTheme.regular,
    );

    text.add(MoveEffect.by(
      Vector2(0, -50),
      EffectController(duration: 0.5),
    ));
    text.add(RemoveEffect(delay: 0.5));
    game.add(text);
  }

  void checkGameEnd() {
    bool isHatched = (current == EggState.chickenHatched ||
        current == EggState.penguinHatched ||
        current == EggState.dragonHatched ||
        current == EggState.wyvernHatched ||
        current == EggState.lizardHatched);
    if (isHatched) {
      game.winGame();
    } else if (game.health <= 0 && !isHatched) {
      game.gameOver();
    }
  }
}
