import 'package:flutter/material.dart';

class GameOverDialog {
  void show({BuildContext context, Function onRestart}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Game Over",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(primary: Colors.green.shade400),
                child: Text("Restart"),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
