import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:new_dino_adventure/components/custom_hitbox.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

class Fruit extends SpriteAnimationComponent with HasGameRef<DinoAdventures>{
  final String fruit;
  Fruit({this.fruit = 'Apple',position,size}) : super(position: position,size: size,);
  final double stepTime = 0.12;
  //final hitbox = CustomHitbox(offsetX: 10, offsetY: 10, width: 12, height: 12);
  
  @override
  FutureOr<void> onLoad() {
    debugMode=true;
    priority=-1;

    /*add(RectangleHitbox(
      position:Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height), collisionType: CollisionType.passive,
    ),);*/
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('7 - Other/$fruit.png'), SpriteAnimationData.sequenced(
      amount: 17,
      stepTime: stepTime,
      textureSize: Vector2.all(32),
      ));
    return super.onLoad();
  }
}