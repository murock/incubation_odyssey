import 'dart:async';

import 'package:flame/components.dart';

class EggComponent extends SpriteAnimationComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'dan_egg_sprite_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(27, 24),
      ),
    );
    scale = Vector2.all(10);
    return super.onLoad();
  }
}
