import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
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

class Egg extends SpriteGroupComponent with HasGameRef {
  final double _textureWidth = 43;
  final double _textureHeight = 60;
  final double _margin = 2;

  @override
  FutureOr<void> onLoad() async {
    // scale = Vector2.all(5);
    // y = 100;
    // x = 100;
    final double damaged1Pos = _textureHeight;
    final double damaged2Pos = _textureHeight * 2;
    final double hatchedPos = _textureHeight * 3;

    final double penguinXPos = _textureWidth + _margin;
    final double wyvernXPos = _textureWidth * 2 + _margin;
    final double lizardXPos = _textureWidth * 3 + _margin;
    final double dragonXPos = _textureWidth * 4 + _margin;
    sprites = {
      EggState.chicken: await _getSprite(srcPosition: Vector2(_margin, 0)),
      EggState.chickenDamaged1:
          await _getSprite(srcPosition: Vector2(_margin, damaged1Pos)),
      EggState.chickenDamaged2:
          await _getSprite(srcPosition: Vector2(_margin, damaged2Pos)),
      EggState.chickenHatched:
          await _getSprite(srcPosition: Vector2(_margin, hatchedPos)),
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

  Future<Sprite> _getSprite({required Vector2 srcPosition}) async {
    return await game.loadSprite(
      srcPosition: srcPosition,
      srcSize: Vector2(_textureWidth, _textureHeight),
      'player/egg_sprite_sheet.png',
    );
  }

  void setState({required int Health, required double heat}) {
    if (heat == 0) {
      if (Health == 3) {
        current = EggState.chicken;
      } else if (Health == 2) {
        current = EggState.chickenDamaged1;
      } else if (Health == 1) {
        current = EggState.chickenDamaged2;
      } else {
        current = EggState.chickenHatched;
      }
    } else if (heat == 10) {
      if (Health == 3) {
        current = EggState.lizard;
      } else if (Health == 2) {
        current = EggState.lizardDamaged1;
      } else if (Health == 1) {
        current = EggState.lizardDamaged2;
      } else {
        current = EggState.lizardHatched;
      }
    } else if (heat == 20) {
      if (Health == 3) {
        current = EggState.dragon;
      } else if (Health == 2) {
        current = EggState.dragonDamaged1;
      } else if (Health == 1) {
        current = EggState.dragonDamaged2;
      } else {
        current = EggState.dragonHatched;
      }
    } else if (heat == -10) {
      if (Health == 3) {
        current = EggState.penguin;
      } else if (Health == 2) {
        current = EggState.penguinDamaged1;
      } else if (Health == 1) {
        current = EggState.penguinDamaged2;
      } else {
        current = EggState.penguinHatched;
      }
    } else if (heat == -20) {
      if (Health == 3) {
        current = EggState.wyvern;
      } else if (Health == 2) {
        current = EggState.wyvernDamaged1;
      } else if (Health == 1) {
        current = EggState.wyvernDamaged2;
      } else {
        current = EggState.wyvernHatched;
      }
    }
  }
}
