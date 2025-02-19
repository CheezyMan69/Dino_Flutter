import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_dino_adventure/dino_adventures.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  DinoAdventures game = DinoAdventures();
  runApp(GameWidget(game: kDebugMode ? DinoAdventures() : game),
  );
}

