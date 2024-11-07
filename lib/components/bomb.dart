
import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';

class Bomb extends SpriteComponent with CollisionCallbacks, HasGameRef<flappybirdgame> {
  final String bombImage = 'bomb.png'; // Nama file gambar bom

  Bomb() : super(size: Vector2(50, 50)); // Tentukan ukuran bom di konstruktor

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite(bombImage); // Muat sprite di sini
    add(CircleHitbox()); // Tambahkan hitbox untuk kolisi
    position = Vector2(Random().nextDouble() * (800 - size.x), 0); // Set posisi awal
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += 200 * dt; // Gerakkan bom ke bawah

    // Jika bom keluar dari layar, Anda bisa menghapusnya
    if (position.y > 600) { // Misalnya, jika tinggi layar 600
      debugPrint('Bomb removed');
      removeFromParent();
    }
  }
}

