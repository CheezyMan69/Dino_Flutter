import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

enum PlayerState {idle, running}

enum PlayerDirection {left, right, none}

class Player extends SpriteAnimationGroupComponent with HasGameRef<DinoAdventures>, KeyboardHandler{
  String character;
  Player({position,  this.character = 'doux'}) : super(position: position);
  late final SpriteAnimation idleAni;
  late final SpriteAnimation runAni;
  final double stepTime = 0.12;

  PlayerDirection playerDirection = PlayerDirection.none;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isRight = true;

  @override
  FutureOr<void> onLoad() {
    _loadAllAni();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) || keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) || keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if(isLeftKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if(isLeftKeyPressed){
      playerDirection = PlayerDirection.left;
    } else if(isRightKeyPressed){
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }
    
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
    double dirx = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if(isRight) {
          flipHorizontallyAroundCenter();
          isRight = false;
        }
        current = PlayerState.running;
        dirx -= moveSpeed;
        break;
      case PlayerDirection.right:
        if(!isRight){
          flipHorizontallyAroundCenter();
          isRight = true;
        }
        current = PlayerState.running;
        dirx += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }

    velocity = Vector2(dirx, 0.0);
    position += velocity * dt;
  }
}