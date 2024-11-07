import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_flutter/components/fruit_group.dart';
import 'package:game_flutter/game/assets.dart';
import 'package:game_flutter/game/bird_movement.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';
import 'package:game_flutter/game/configuration.dart';

import 'package:game_flutter/components/bomb.dart';

import 'fruit.dart';

class Bird extends SpriteGroupComponent<Birdmovement> with HasGameRef<flappybirdgame>, CollisionCallbacks
{
  Bird();
  final double speed = 40;
  int score = 0;

  @override
  Future<void> onLoad() async
  {
    add(CircleHitbox());
    final birdleft = await gameRef.loadSprite(assets.birdleft);
    final birdright = await gameRef.loadSprite(assets.birdright);

    sprites = {
      Birdmovement.left: birdleft,
      Birdmovement.right: birdright,
    };
    // Menentukan ukuran dan posisi burung setelah sprite terinisialisasi
    size = Vector2(50, 40);
    position = Vector2(180, 630);
    // Menentukan state awal (misal: middle flap)
    current = Birdmovement.left;
  }

  void runright() {
    position.x += speed;
    if(position.x > gameRef.size.x){
      position.x = -size.x;
    }
    current = Birdmovement.right;
  }

  void runleft() {
    position.x -= speed;
    if(position.x < 0){
      position.x = gameRef.size.x;
    }
    current = Birdmovement.left;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);

    // Jika burung memakan buah
    if (other is Fruit) {
      FlameAudio.play('Minecraft_Eating.mp3');
      updatescore();
      //removeFromParent(); // Menghapus buah dari permainan
    }

    // Jika burung terkena bom
    if (other is Bomb) {
      FlameAudio.play('explosion_meme.mp3');
      gameover(); // Menjalankan fungsi gameover
    }
  }

  void updatescore() {
    gameRef.bird.score += 1;
    gameRef.score.text = 'Score: ${gameRef.bird.score}';
    //FlameAudio.play(assets.point); // Memainkan suara saat skor bertambah
  }

  void reset() {
    position = Vector2(180, 630);
    score = 0;
  }

  void gameover() {
    FlameAudio.play('explosion_meme.mp3',volume: 0.3);
    gameRef.overlays.add('gameover');
    gameRef.pauseEngine();
    FlameAudio.play(assets.gameovermusic);
    gameRef.ishit = true; // Mengubah status game menjadi hit
  }

  @override
  void update(double dt) {
    super.update(dt);
    //position.y += config.birdvelocity * dt;
    // if(position.x < 0) {
    //   updatescore();
    // }
  }
}
