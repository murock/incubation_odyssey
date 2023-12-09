import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  @override
  Widget build(BuildContext context) {
    return GameWidget(game: MainGame(),);
  }
}