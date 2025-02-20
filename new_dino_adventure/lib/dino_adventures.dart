import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:new_dino_adventure/levels/level.dart';
import 'package:new_dino_adventure/actors/player.dart';
import 'package:flutter/painting.dart';

class DinoAdventures extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks{
  
  //@override
  //Color backgroundColor() => const Color(); 
  
  late final CameraComponent cam;
  Player player = Player(character: 'mort');
  late JoystickComponent joystick;
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async{

    await images.loadAllImages(); //loads everying in to cache (prepare to crash)

    final world = Level( player: player,levelName: 'Level1');
    
    cam = CameraComponent.withFixedResolution(
      world: world, width: 480,height: 320);
    //cam.viewfinder.anchor = Anchor.topLeft;
    
    addAll([cam, world]);

    if (showJoystick){
    addJoystick();
    }
    cam.follow(player);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoystick){
    updateJoystick();
    }
    super.update(dt);
  }
  
  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(images.fromCache('11 - HUD/Knob.png')),
      ),
      background: SpriteComponent(
        sprite:Sprite(images.fromCache('11 - HUD/Joystick.png')),
      ),

    margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joystick);
  }
  
  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horiMove = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horiMove = 1;
        break;  
      default:
        player.horiMove =0;
      break;
    }

  }
}