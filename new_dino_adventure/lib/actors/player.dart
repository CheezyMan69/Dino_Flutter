import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

enum PlayerState {idle, running}



class Player extends SpriteAnimationGroupComponent with HasGameRef<DinoAdventures>, KeyboardHandler{
  String character;
  Player({position,  this.character = 'doux'}) : super(position: position);
  late final SpriteAnimation idleAni;
  late final SpriteAnimation runAni;
  final double stepTime = 0.12;

  double horiMove = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();


  @override
  FutureOr<void> onLoad() {
    _loadAllAni();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    _updatePlayerState();
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horiMove = 0;
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || 
      keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || 
      keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horiMove+= isLeftKeyPressed ? -1 : 0;
    horiMove+= isRightKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
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
  
  void _updatePlayerMovement(double dt) {
    velocity.x = horiMove * moveSpeed;
    position.x += velocity.x * dt;
  }
  
  void _updatePlayerState() {
    PlayerState playerState = PlayerState.idle;
    if(velocity.x < 0 && scale.x > 0){
      flipHorizontallyAroundCenter();
    } else if(velocity.x > 0 && scale.x <0){
      flipHorizontallyAroundCenter();
    }

    if(velocity.x > 0 || velocity.x < 0) playerState = PlayerState.running;
    
    current = playerState;
  }
}