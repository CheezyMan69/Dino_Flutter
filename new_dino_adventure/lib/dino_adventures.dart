import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:new_dino_adventure/levels/level.dart';
import 'package:new_dino_adventure/actors/player.dart';
import 'package:flutter/painting.dart';

class DinoAdventures extends FlameGame with HasKeyboardHandlerComponents, DragCallbacks,HasCollisionDetection{
  
  //@override
  //Color backgroundColor() => const Color(); 
  
  late CameraComponent cam;
  Player player = Player(character: 'mort');
  late JoystickComponent joystick;
  bool showJoystick = false;
  List<String> levelNames = ['Level1','Level2','Level3','Level4','Level5','Level6','Level7','End'];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async{

    await images.loadAllImages(); //loads everying in to cache (prepare to crash)

    _loadLevel();
    //cam.viewfinder.anchor = Anchor.topLeft;
    
    

    if (showJoystick){
    addJoystick();
    }
  

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

  void loadNextLevel() {
    if(currentLevelIndex  < levelNames.length - 1){
      currentLevelIndex++;

      _loadLevel();

    } else{
      //no more levels
    }

  }
  
  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1),(){
    Level world = Level(levelName: levelNames[currentLevelIndex],player: player);

    cam = CameraComponent.withFixedResolution(
    world: world, width: 480,height: 320,);
    addAll([world,cam]);
    cam.follow(player);
    });

  }
}