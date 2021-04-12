class Screen {
  double screenWidth;
  double screenHeight;

  Screen(this.screenWidth, this.screenHeight);
}

class Position {
  double x;
  double y;

  Position(this.x, this.y);

  static bool intersects(Position pos1, Position pos2, double pointSize) {
    return pos1.x + pointSize > pos2.x &&
        pos1.x < pos2.x + pointSize &&
        pos1.y < pos2.y + pointSize &&
        pos1.y + pointSize > pos2.y;
  }
}

abstract class IGameObject {
  Position position;

  void update(double x, double y);
}

enum GameStates { playing, paused, gameOver }
