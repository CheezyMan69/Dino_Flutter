import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:new_dino_adventure/actors/player.dart';
//import 'package:tiled/tiled.dart';

class Level extends World{
  late TiledComponent level;
  
  @override
  FutureOr<void> onLoad() async{
    
    level = await TiledComponent.load('Level2.tmx', Vector2(16, 16));

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    for(final spawnPoint in spawnPointsLayer!.objects) {
      switch (spawnPoint.class_) {
        case 'Player':
        final player = Player(character: 'mort', position: Vector2(spawnPoint.x, spawnPoint.y));
        add(player);
          
          break;
        default:
      }

    }
    return super.onLoad();
  }
}