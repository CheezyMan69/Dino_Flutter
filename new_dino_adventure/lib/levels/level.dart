import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:new_dino_adventure/actors/player.dart';
import 'package:new_dino_adventure/components/collision_block.dart';
import 'package:new_dino_adventure/components/fruit.dart';
//import 'package:tiled/tiled.dart';

class Level extends World{
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player}); 
  late TiledComponent level;
  List<CollisionBlock> collisionBlocks = [];
  
  @override
  FutureOr<void> onLoad() async{
    
    level = await TiledComponent.load('$levelName.tmx', Vector2(16, 16));

    add(level);
    _spawningObjects();
    _addCollisions();

    return super.onLoad();
   }

    void _spawningObjects() {
    
    
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if(spawnPointsLayer != null){
      for(final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
          case 'Fruit':
          final fruit = Fruit(
            fruit: spawnPoint.name,
            position: Vector2(spawnPoint.x, spawnPoint.y),
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(fruit);
          default:
        }

      }
    }
    }

    void _addCollisions(){
    final collLayer = level.tileMap.getLayer<ObjectGroup>('Collisions');

    if(collLayer != null){
      for(final coll in collLayer.objects){
        switch(coll.class_){
          case 'Platform':
            final platform = CollisionBlock(position: Vector2(coll.x, coll.y),
            size: Vector2(coll.width, coll.height),
            isPlatform: true);
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
          final block = CollisionBlock(position: Vector2(coll.x, coll.y),
          size: Vector2(coll.width, coll.height));
          collisionBlocks.add(block);
          add(block);
        }
      }
    }
    player.collisionBlocks = collisionBlocks;
  }
}