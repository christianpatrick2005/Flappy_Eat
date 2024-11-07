
import 'package:game_flutter/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final flappybirdgame game;
  static const String id = 'gameover';

   const GameOverScreen({super.key, required this.game});


  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
        child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: ${game.bird.score}',
              style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Game',
                  color: Colors.white
              ),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/images/gameover.png'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Restart', style: TextStyle(fontSize: 20, fontFamily: 'Game'),
              ),
            ),
            ElevatedButton(
              onPressed: onExit,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('EXIT', style: TextStyle(fontSize: 20, fontFamily: 'Game'),
              ),
            ),
            const SizedBox(height: 40),
            Image.asset('assets/images/jomok.jpeg'),
          ],
        ),
      ),
    );
  }

  void onExit(){
    game.bird.reset();
    game.overlays.remove('gameover');
    game.overlays.add('mainmenu');
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameover');
    game.resumeEngine();
  }
}
