import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';
import 'package:game_flutter/game/assets.dart';

class MainMenuScreen extends StatefulWidget {
  final flappybirdgame game;
  static const String id = 'mainmenu';

  const MainMenuScreen({Key? key, required this.game}) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  void initState() {
    super.initState();
    // Memainkan musik latar belakang saat halaman menu dibuka
    FlameAudio.bgm.play('Suspended.ogg', volume: 1.0);
    widget.game.pauseEngine(); // Menjeda game saat di menu
  }

  @override
  void dispose() {
    // Berhenti memutar musik saat halaman menu ditutup
    FlameAudio.bgm.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FlameAudio.play(assets.point, volume: 1.0);
          widget.game.overlays.remove('mainmenu');
          widget.game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/menu.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Image.asset('assets/images/message_new.png'),
        ),
      ),
    );
  }
}

