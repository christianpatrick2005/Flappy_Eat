import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:game_flutter/components/background.dart';
import 'package:game_flutter/components/bird.dart';
import 'package:game_flutter/components/bomb.dart';
import 'package:game_flutter/components/ground.dart';
import 'package:game_flutter/components/fruit.dart';
import 'package:game_flutter/game/configuration.dart';
import 'package:flame/timer.dart';  // Import Flame Timer
import 'package:game_flutter/components/fruit.dart';
import 'dart:async';

class flappybirdgame extends FlameGame with TapDetector, HasCollisionDetection {
  flappybirdgame();

  late SpriteComponent leftbutton;
  late SpriteComponent rightbutton;

  late Bird bird;
  late TextComponent score;
  bool ishit = false;
  Timer? spawnFruitTimer; // Deklarasi timer
  late Timer bombSpawnTimer;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final leftSprite = await loadSprite('button_left.png');
    final rightSprite = await loadSprite('button_right.png');

    leftbutton = SpriteComponent(
      sprite: leftSprite,
      position: Vector2(50, size.y - 100),
      size: Vector2(50, 50),
      priority: 1,
    );

    rightbutton = SpriteComponent(
      sprite: rightSprite,
      position: Vector2(size.x - 100, size.y - 100),
      size: Vector2(50, 50),
      priority: 1,
    );

    add(leftbutton);
    add(rightbutton);

    addAll([
      background(),
      ground(),
      Bomb(),
      bird = Bird(),
      score = buildscore(),
    ]);

    // Mulai timer untuk spawn buah
    spawnFruitTimer = Timer(
      0.5, // Interval waktu spawn
      repeat: true,
      onTick: spawnFruit, // Panggil fungsi spawnFruit
    )..start();

    bombSpawnTimer = Timer(
        1.0,
        repeat: true,
        onTick: spawnBomb
    );
    bombSpawnTimer.start();
  }

  TextComponent buildscore() {
    return TextComponent(
      text: 'Score: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Game',
        ),
      ),
    );
  }

  void spawnFruit() {
    // Panggil metode spawnFruit dari kelas Fruit
    Fruit.create().then((fruit) {
      add(fruit); // Menambahkan buah yang telah dibuat ke game
    });
  }

  void spawnBomb() {
    Bomb bomb = Bomb(); // Buat objek bom baru
    add(bomb); // Tambahkan bom ke dalam game
    print("Bom spawned at position: ${bomb.position}");
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (leftbutton.containsPoint(info.eventPosition.global)) {
      moveleft();
    } else if (rightbutton.containsPoint(info.eventPosition.global)) {
      moveright();
    }
  }

  void moveleft() {
    bird.runleft();
  }

  void moveright() {
    bird.runright();
  }

  @override
  void update(double dt) {
    super.update(dt);
    spawnFruitTimer?.update(dt); // Update timer setiap frame
    bombSpawnTimer.update(dt);
    score.text = 'Score: ${bird.score}';
  }
}


