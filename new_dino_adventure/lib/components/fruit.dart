import 'dart:async';

import 'package:flame/components.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<DinoAdventures>{
  final String fruit;
  Fruit({this.fruit = 'Apple',position,size}) : super(position: position,size: size,);
  final double stepTime = 0.12;
  
  @override
  FutureOr<void> onLoad() {
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('7 - Other/$fruit.png'), SpriteAnimationData.sequenced(
      amount: 17,
      stepTime: stepTime,
      textureSize: Vector2.all(32),
      ));
    return super.onLoad();
  }
}