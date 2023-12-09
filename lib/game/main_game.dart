import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/animations/egg_component.dart';
import 'package:incubation_odyssey/game/background/background.dart';

class MainGame extends FlameGame {
  @override
  Color backgroundColor() => Colors.purple;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    add(BackgroundHolder());
    add(EggComponent());

    // final spriteBatch = await SpriteBatch.load('egg_sprite_sheet.png');

    // spriteBatch.add(
    //   source: const Rect.fromLTWH(0, 0, 27, 24),
    //   //offset: Vector2.all(200),
    //   color: Colors.greenAccent,
    //   scale: 2,
    //   rotation: pi / 9.0,
    //   anchor: Vector2.all(64),
    // );

    // spriteBatch.addTransform(
    //   source: const Rect.fromLTWH(0, 0, 27, 24),
    //   color: Colors.redAccent,
    // );

    // const num = 100;
    // final r = Random();
    // for (var i = 0; i < num; ++i) {
    //   final sx = r.nextInt(8) * 128.0;
    //   final sy = r.nextInt(8) * 128.0;
    //   final x = r.nextInt(size.x.toInt()).toDouble();
    //   final y = r.nextInt(size.y ~/ 2).toDouble() + size.y / 2.0;
    //   spriteBatch.add(
    //     source: Rect.fromLTWH(sx, sy, 128, 128),
    //     offset: Vector2(x - 64, y - 64),
    //   );
    // }

    // add(
    //   SpriteBatchComponent(
    //     spriteBatch: spriteBatch,
    //     blendMode: BlendMode.srcOver,
    //   ),
    // );

    // final PaintDecorator paintDecorator = PaintDecorator.tint(Colors.green);
    // final Sprite sprite = await loadSprite('does_alpha_work.png');
    // add(SpriteComponent(
    //   sprite: sprite,
    //   position: size / 2,
    //   size: sprite.srcSize * 2,
    //   anchor: Anchor.center,
    // ));
  }
}
