import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PauseDialog {
  void show({BuildContext context, Function onResume}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade900,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Pause",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onResume,
                style: ElevatedButton.styleFrom(primary: Colors.grey.shade700),
                child: Text("Resume"),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
