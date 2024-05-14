import 'package:flutter/material.dart';
import 'bmi.dart';
import 'button_style.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Bmi()),
                );
              },
              style: MyButtonStyle.outlinedButtonStyle, // 버튼 스타일 적용
              child: Text('BMI 계산기'),
            ),
          ],
        ),
      ),
    );
  }
}
