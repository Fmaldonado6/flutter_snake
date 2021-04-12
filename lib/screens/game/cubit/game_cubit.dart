import 'dart:collection';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/models/models.dart';

import 'game_state.dart';

class GameCubit extends Cubit<GameEvent> {
  GameCubit() : super(GameState(GameStates.playing));

  var gameState = GameStates.playing;
  var score = 0;
  final random = Random();
  var pointSize = 0.0;
  var snake = [];
  final inputs = Queue<SwipeDirection>();
  var apple = Position(0, 0);
  var velx = 10.0;
  var vely = 10.0;
  var direction = SwipeDirection.right;
  Screen screen = Screen(0, 0);

  void setScreen(Screen screen) {
    this.screen = screen;
  }

  void fingerSwipe(SwipeDirection direction) {
    print(direction);
    if (canSwipe(direction)) {
      if (inputs.isNotEmpty && inputs.first == direction || inputs.length > 4)
        return;
      inputs.add(direction);
    }
    print(inputs.length);
  }

  void startGame() {
    pointSize = (screen.screenWidth / 20).floorToDouble();
    velx = vely = pointSize;
    direction = SwipeDirection.right;
    inputs.add(direction);
    score = 0;
    emit(AddPoint(score));
    generateSnake();
    generateApple();
    gameLoop();
  }

  void generateSnake() {
    snake.clear();
    for (var i = 3; i > 0; i--) {
      snake.add(Position(i * pointSize, 0));
    }
  }

  void gameLoop() async {
    while (gameState == GameStates.playing) {
      update();
      await Future.delayed(Duration(milliseconds: 1000 ~/ 10));
    }
  }

  update() {
    for (var i = snake.length - 1; i > 0; i--) {
      snake[i].x = snake[i - 1].x;
      snake[i].y = snake[i - 1].y;
    }
    if (inputs.isNotEmpty) direction = inputs.removeFirst();
    switch (direction) {
      case SwipeDirection.left:
        snake.first.x -= velx;
        break;
      case SwipeDirection.right:
        snake.first.x += velx;
        break;
      case SwipeDirection.down:
        snake.first.y -= vely;
        break;
      case SwipeDirection.up:
        snake.first.y += vely;
        break;
    }
    if (snake.first.x < 0 ||
        snake.first.y < 0 ||
        snake.first.x > screen.screenWidth - pointSize ||
        snake.first.y > screen.screenHeight - pointSize) gameOver();

    if (Position.intersects(snake.first, apple, pointSize)) addPoint();
  }

  List<Widget> draw() {
    final List<Widget> list = [];

    for (var i = 0; i < snake.length; i++) {
      list.add(
        Positioned(
          top: snake[i].y,
          left: snake[i].x,
          child: Container(
            color: Colors.white,
            width: pointSize,
            height: pointSize,
          ),
        ),
      );
    }

    list.add(
      Positioned(
        top: apple.y,
        left: apple.x,
        child: Container(
          color: Colors.red,
          width: pointSize,
          height: pointSize,
        ),
      ),
    );

    emit(Draw());

    return list;
  }

  void gameOver() {
    gameState = GameStates.gameOver;
    inputs.clear();
    emit(GameState(gameState));
  }

  void restart() {
    gameState = GameStates.playing;
    startGame();
  }

  void pause() {
    gameState = GameStates.paused;
    inputs.clear();
    emit(GameState(gameState));
  }

  void resume() {
    gameState = GameStates.playing;
    emit(GameState(gameState));
    gameLoop();
  }

  void addPoint() {
    emit(AddPoint(++score));
    generateApple();
    snake.add(Position(snake.last.x, snake.last.y));
  }

  void generateApple() {
    final newX = random.nextInt(20) * pointSize;
    final newY = random.nextInt(20) * pointSize;

    apple = Position(newX, newY);
  }

  bool canSwipe(SwipeDirection newDirection) {
    if (direction == SwipeDirection.left &&
        newDirection == SwipeDirection.right) return false;

    if (direction == SwipeDirection.right &&
        newDirection == SwipeDirection.left) return false;

    if (direction == SwipeDirection.down && newDirection == SwipeDirection.up)
      return false;

    if (direction == SwipeDirection.up && newDirection == SwipeDirection.down)
      return false;

    return true;
  }
}
