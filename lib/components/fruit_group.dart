// import 'package:flame/collisions.dart';
// import 'package:game_flutter/game/assets.dart';
// import 'dart:math';
// import 'package:flame/components.dart';
// import 'package:flame_audio/flame_audio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:game_flutter/components/fruit.dart';
// import 'package:game_flutter/game/flappy_bird_game.dart';
// import 'package:game_flutter/game/configuration.dart';
// import 'package:game_flutter/screens/game_over_screen.dart';
//
// import 'package:game_flutter/components/bird.dart';
// import 'package:game_flutter/components/bomb.dart';
//
//
// class fruit_group extends SpriteComponent with CollisionCallbacks, HasGameRef<flappybirdgame> {
//   fruit_group({required Sprite sprite})
//       : super(sprite: sprite, size: Vector2(50, 50)) {
//     // Set posisi awal di atas layar secara acak
//     position = Vector2(Random().nextDouble() * (800 - size.x), 0); // 800 adalah lebar layar
//   }
//
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     add(CircleHitbox());
//   }
//
//   void gameover() {
//     gameRef.ishit = true;
//     gameRef.overlays.add('gameover');
//     gameRef.pauseEngine();
//     FlameAudio.play('Ambatukam.mp3');
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     // Gerakkan buah ke bawah
//     position.y += 200 * dt; // 200 piksel per detik
//
//     if(position.x < 182) {
//       removeFromParent();
//       debugPrint('fruit removed');
//     }
//   }
// }
