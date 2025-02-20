import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:new_dino_adventure/components/collision_block.dart';
import 'package:new_dino_adventure/components/utils.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

enum PlayerState {idle, running}



class Player extends SpriteAnimationGroupComponent with HasGameRef<DinoAdventures>, KeyboardHandler{
  String character;
  Player({position,  this.character = 'doux'}) : super(position: position);
  late final SpriteAnimation idleAni;
  late final SpriteAnimation runAni;
  final double stepTime = 0.12;

  final double _gravity = 9.8;
  final double _jumpForce = 460;
  final double _terminalVelocity = 300;
  double horiMove = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  List<CollisionBlock> collisionBlocks = [];


  @override
  FutureOr<void> onLoad() {
    _loadAllAni();
    debugMode = true;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlayerMovement(dt);
    _updatePlayerState();
    _checkHoriColl(); //allows before gravity
    _applyGravity(dt);
    _checkVertColl();
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
  
  void _checkHoriColl() {
    for(final block in collisionBlocks){
      if(!block.isPlatform){
        if(checkColl(this, block)){
          if(velocity.x > 0){
            velocity.x = 0;
            position.x = block.x - width;
            break;
          }
          if (velocity.x < 0){
            velocity.x = 0;
            position.x = block.x + block.width + width;
            break;
          }
        }
      }
    }
  }
  
  void _applyGravity(double dt) {
    velocity.y += _gravity;
    velocity.y = velocity.y.clamp(-_jumpForce, _terminalVelocity); //clamp is min and max for value
    position.y += velocity.y * dt;
  }
  
  void _checkVertColl() {
    for(final block in collisionBlocks){
      if(block.isPlatform){

      }else {
        if(checkColl(this, block)){
          if(velocity.y > 0){
            velocity.y = 0;
            position.y = block.y - width;
            isOnGround = true;
            break;
          }
          if(velocity.y < 0){
            velocity.y = 0;
            position.y = block.y + block.height;
          }
        }
      }
    }
  }
}