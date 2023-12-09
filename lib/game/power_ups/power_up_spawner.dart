import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/variables.dart';

class PowerUpSpawner extends Component with HasGameRef {
  PowerUpSpawner(
      {super.children,
      super.priority,
      super.key,
      required this.textureWidth,
      required this.textureHeight});

  final double textureWidth;
  final double textureHeight;

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
    var intValue = Random().nextInt(PowerUpType
        .values.length); // Value is >= 0 and < the total number of power ups
    late final PowerUpType powerUpType = PowerUpType.values[intValue];
    print(intValue);
    print(powerUpType);
    PowerUp powerUp = PowerUp(
      numFrames: 1,
      textureSize: Vector2(151, 151),
      powerUpType: powerUpType,
    );
    add(powerUp);
  }
}
