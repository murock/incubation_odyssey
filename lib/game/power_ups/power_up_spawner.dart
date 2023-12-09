import 'dart:async';

import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/variables.dart';

class PowerUpSpawner extends Component with HasGameRef {
  late Timer _timer;

  @override
  FutureOr<void> onLoad() {
    _timer = Timer(
      Variables.initialpowerUpSpawnRate,
      repeat: true,
      onTick: _spawn,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  void _spawn() {
    PowerUp powerUp = PowerUp(
      numFrames: 1,
      textureSize: Vector2(151, 151),
      powerUpType: PowerUpType.iceCube,
    );
    add(powerUp);
  }
}
