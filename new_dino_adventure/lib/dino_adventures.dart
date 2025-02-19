import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:new_dino_adventure/levels/level.dart';

class DinoAdventures extends FlameGame {
  
  //@overide
  //Color backgroundColor() => const Color();
  
  late final CameraComponent cam;

  final world = Level();

  @override
  FutureOr<void> onLoad() async{

    await images.loadAllImages(); //loads everying in to cache (prepare to crash)
    
    cam = CameraComponent.withFixedResolution(
      world: world, width: 2400,height: 320);
    cam.viewfinder.anchor = Anchor.topLeft;
    
    addAll([cam, world]);

    return super.onLoad();
  }
}