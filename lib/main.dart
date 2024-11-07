import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';
import 'package:game_flutter/screens/main_menu_screen.dart';
import 'package:game_flutter/screens/game_over_screen.dart';


void main() {
  final game = flappybirdgame();
  runApp(
      GameWidget(
        game: game,
        initialActiveOverlays: const [MainMenuScreen.id],
        overlayBuilderMap: {
          'mainmenu': (context, _) => MainMenuScreen(game: game),
          'gameover': (context, _) => GameOverScreen(game: game),
        },
      )
   );
}


