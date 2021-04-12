import 'package:flutter/material.dart';
import 'package:flutter_snake/models/models.dart';

class GameObject extends StatelessWidget implements IGameObject {
  Position position;

  final Color color;

  final double pointSize;

  GameObject({
    Key key,
    @required this.color,
    @required this.position,
    @required this.pointSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: position.y,
      left: position.x,
      child: Container(
        color: Colors.white,
        width: pointSize,
        height: pointSize,
      ),
    );
  }

  @override
  void update(double x, double y) {
    this.position.x = x;
    this.position.y = y;
  }
}
