
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:game_flutter/game/assets.dart';
import 'package:game_flutter/game/flappy_bird_game.dart';

class background extends SpriteComponent with HasGameRef<flappybirdgame>{
  background();

  @override
  Future<void>? onLoad() async {
    final background = await Flame.images.load(assets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
