import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

class Spike extends SpriteAnimationComponent with HasGameRef<DinoAdventures>{
  Spike({
    position, size,
  }) : super(position: position, size: size,);

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    debugMode = false;
    animation = SpriteAnimation.fromFrameData(game.images.fromCache('5 - Misc. universal tiles/spikes.png'), SpriteAnimationData.sequenced(amount: 1,stepTime: 0.12, textureSize: Vector2.all(16),));
    return super.onLoad();
  }
}