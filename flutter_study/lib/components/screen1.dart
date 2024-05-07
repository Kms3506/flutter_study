import 'package:flutter/material.dart';
import 'bmi.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bmi()),
                );
              },
              child: Text('BMI 계산기'),
            ),
          ],
        ),
      ),
    );
  }
}
