bool checkColl(player, block){
  final playerX = player.position.x;
  final playerY = player.position.y;
  final playerWidth = player.width;
  final playerHeight = player.height;

  final blockX= block.x;
  final blockY = block.y;
  final blockWidth = block.width;
  final blockHeight = block.height;

  final fixedX = player.scale.x < 0 ? playerX - playerWidth: playerX;

  return (
    playerY < blockY + blockHeight && //if player y is less that bottom of block
     playerY + playerHeight > blockY && //if bottom of player is greater than top of block
     fixedX < blockX + blockWidth && //if left of player is less than right of block
     fixedX + playerWidth > blockX // if right of player is greater than left of block
  );

}