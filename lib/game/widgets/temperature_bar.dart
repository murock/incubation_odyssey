import 'package:flutter/material.dart';

class TemperatureBar extends StatelessWidget {
  final double temperature; // Temperature in Celsius or Fahrenheit

  TemperatureBar({required this.temperature});

  LinearGradient _getGradient() {
    // Define temperature ranges and corresponding gradient colors
    if (temperature <= 10.0) {
      return const LinearGradient(
        colors: [Colors.blue, Colors.blueGrey],
        stops: [0.0, 1.0],
      );
    } else if (temperature >= 10.0 && temperature <= 70.0) {
      return const LinearGradient(
        colors: [Colors.yellow, Colors.orange],
        stops: [0.0, 1.0],
      );
    } else {
      return const LinearGradient(
        colors: [Colors.red, Colors.pink],
        stops: [0.0, 1.0],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 20.0,
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0), // Set rounded corners
                gradient: _getGradient(),
              ),
            ),
            Container(
              height: 20.0,
              width: 2.0,
              color: Colors.black, // Vertical line at 0 degrees mark
            ),
          ],
        ),
        const SizedBox(height: 5.0), // Spacer between bar and temperature number
        Text(
          "${temperature.toString()}°c",
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }
}
