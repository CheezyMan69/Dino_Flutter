import 'dart:async';

import 'package:flame/components.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

enum PlayerState {idle, running}

class Player extends SpriteAnimationGroupComponent with HasGameRef<DinoAdventures>{
  String character;
  Player({position, required this.character}) : super(position: position);
  late final SpriteAnimation idleAni;
  late final SpriteAnimation runAni;
  final double stepTime = 0.12;


  @override
  FutureOr<void> onLoad() {
    _loadAllAni();
    return super.onLoad();
  }

  void _loadAllAni(){
    idleAni = _spriteAni('idle', 3);
    runAni = _spriteAni('run', 7);



    animations = {PlayerState.idle: idleAni,
      PlayerState.running: runAni};
    current = PlayerState.running;
    
  }
  

  SpriteAnimation _spriteAni(String state, int amount){
    return SpriteAnimation.fromFrameData(game.images.fromCache('6 - Characters/$character-$state.png'),
     SpriteAnimationData.sequenced(
      amount: amount,
      stepTime: stepTime,
       textureSize: Vector2(24, 24),));

  }
}