import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:new_dino_adventure/actors/player.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

class Checkpoint extends SpriteAnimationComponent with HasGameRef<DinoAdventures>, CollisionCallbacks{
  Checkpoint({position, size}): super (position:position,size:size);

  bool reachedCheckpoint = false;

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    add(RectangleHitbox(position: Vector2(18,56),size: Vector2(12,8),collisionType: CollisionType.passive));
    
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('5 - Misc. universal tiles/House (112 x 96).png'),
    SpriteAnimationData.sequenced(
    amount: 1,
    stepTime: 1,
    textureSize: Vector2(112, 96),
    ));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player && !reachedCheckpoint) _reachedCheckpoint();
    super.onCollision(intersectionPoints, other);
  }
  
  void _reachedCheckpoint() {
    reachedCheckpoint = true;
    //animation = 
  }

}