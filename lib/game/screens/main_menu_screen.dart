import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main_game.dart';

class MainMenuScreen extends StatelessWidget {
  final MainGame game;
  static const String id = 'mainmenu';

  const MainMenuScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove(id);
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg_menu.png"), fit: BoxFit.cover)),
          child: Center(
            child: ZoomingButton(),
          ),
        ),
      ),
    );
  }
}

class ZoomingButton extends StatefulWidget {
  @override
  _ZoomingButtonState createState() => _ZoomingButtonState();
}

class _ZoomingButtonState extends State<ZoomingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      vsync: this,
    );

    // Create a Tween animation
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Add a listener to rebuild the widget when the animation value changes
    _animation.addListener(() {
      setState(() {});
    });

    // Repeat the animation indefinitely
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: 64,
        child: const Text(
          'Click to start',
          style: TextStyle(
            color: Colors.white,
            fontSize: 60,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}