import 'package:flutter/material.dart';

class TemperatureBar extends StatelessWidget {
  final double temperature; // Temperature in Celsius or Fahrenheit

  TemperatureBar({required this.temperature});

  Color _getColor() {
    // Define temperature ranges and corresponding colors
    if (temperature <= 10.0) {
      return Colors.blue; // Cold (blue)
    } else if (temperature <= 25.0) {
      return Colors.yellow; // Average (yellow)
    } else {
      return Colors.red; // Hot (red)
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.0,
      width: 200.0,
      child: LinearProgressIndicator(
        value: (temperature - (-20)) / (40 - (-20)),
        valueColor: AlwaysStoppedAnimation<Color>(_getColor()),
        backgroundColor: Colors.white,
      ),
    );
  }
}

