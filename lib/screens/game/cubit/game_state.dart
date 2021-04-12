import 'package:flutter_snake/models/models.dart';

abstract class GameEvent {}

class GameState extends GameEvent {
  final GameStates state;

  GameState(this.state);
}

class Draw extends GameEvent {}

class FingerSwipe extends GameEvent {
  final SwipeDirection direction;

  FingerSwipe(this.direction);
}

class AddPoint extends GameEvent {
  int score;
  AddPoint(this.score);
}

enum SwipeDirection { up, down, left, right }
