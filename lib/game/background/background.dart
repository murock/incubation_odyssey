import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';

class BackgroundHolder extends Component {
  late final Background background;

  @override
  FutureOr<void> onLoad() async {
    background = Background();
    add(background);
    await super.onLoad();
  }
}

class Background extends ParallaxComponent with HasGameRef {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    final List<ParallaxLayer> parrallaxLayers = [
      ParallaxLayer(
        await game.loadParallaxImage(
          'parallax/background1.png',
          filterQuality: FilterQuality.none,
        ),
      ),
      ParallaxLayer(
        await game.loadParallaxImage(
          'parallax/background2.png',
          filterQuality: FilterQuality.none,
        ),
      ),
      ParallaxLayer(
        await game.loadParallaxImage(
          'parallax/background3.png',
          filterQuality: FilterQuality.none,
        ),
      ),
      ParallaxLayer(
        await game.loadParallaxImage(
          'parallax/background4.png',
          filterQuality: FilterQuality.none,
        ),
      )
    ];

    parallax = Parallax(parrallaxLayers, baseVelocity: Vector2(120, 0));
  }
}
