import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:new_dino_adventure/components/custom_hitbox.dart';
import 'package:new_dino_adventure/components/utils.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

enum FruitState {idle, collect}

class Fruit extends SpriteAnimationComponent with HasGameRef<DinoAdventures>{
  final String fruit;
  //late SpriteAnimation idleAni;
  //late SpriteAnimation collectAni;
  Fruit({this.fruit = 'Apple',position,size}) : super(position: position,size: size,);
  final double stepTime = 0.12;
  //final hitbox = CustomHitbox(offsetX: 10, offsetY: 10, width: 12, height: 12);
  
  @override
  FutureOr<void> onLoad() {
    debugMode=false;
    //priority=-1;

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
  /*
  @override
  void update(double dt) {
    _updateFruitState();
    super.update(dt);
  }

    void _updateFruitState() {
    FruitState fruitState = FruitState.idle;

    if(checkCollFruits(game.player, this)) fruitState = FruitState.collect;
    var current = fruitState;
  }
    void _loadAllAni(){
    collectAni = _spriteAni(4);



    animations = {FruitState.idle: idleAni,
      FruitState.collect: collectAni,
     };

    current = FruitState.idle;
    
  }
  

  SpriteAnimation _spriteAni(int amount){
    return SpriteAnimation.fromFrameData(game.images.fromCache('7 - Others/Collected.png'),
     SpriteAnimationData.sequenced(
      amount: amount,
      stepTime: stepTime,
       textureSize: Vector2(24, 24),));

  }
  */
}