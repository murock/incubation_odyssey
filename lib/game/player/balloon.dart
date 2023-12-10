import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:incubation_odyssey/game/main_game.dart';
import 'package:incubation_odyssey/game/player/player.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/variables.dart';

enum PlayerState {
  idle,
  heating,
}

class Balloon extends SpriteGroupComponent with HasGameRef<MainGame> {
  // late Player egg;

  @override
  FutureOr<void> onLoad() async {
    final Sprite idle = await game.loadSprite('player/balloon.png');

    sprites = {
      PlayerState.idle: idle,
    };
    scale = Vector2.all(0.15);
    current = PlayerState.idle;

    // egg = Player();
    // egg.parent = this;
    // egg.x = (size.x / 2) - 100;
    // egg.y = size.y - 320;

    // add(egg);

    return super.onLoad();
  }
}
