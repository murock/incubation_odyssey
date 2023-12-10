import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:incubation_odyssey/game/power_ups/power_up.dart';
import 'package:incubation_odyssey/game/variables.dart';

class PowerUpSpawner extends Component with HasGameRef {
  PowerUpSpawner({
    super.children,
    super.priority,
    super.key,
  });

  late Timer _timer;

  @override
  FutureOr<void> onLoad() {
    _timer = _setupTimer();
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

    PowerUp powerUp = PowerUp(
      powerUpType: powerUpType,
    );
    add(powerUp);

    _timer = _setupTimer();
    _timer.start();
  }

  Timer _setupTimer() {
    final double timerValue =
        Random().nextDouble() * Variables.maxPowerUpSpawnTime;
    return Timer(
      timerValue,
      onTick: _spawn,
    );
  }

  void cleanUp() {
    children.whereType<PowerUp>().forEach((powerup) {
      powerup.removeFromParent();
    });
  }
}
