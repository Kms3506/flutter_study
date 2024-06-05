import 'package:flutter/material.dart';
import 'bmi.dart';
//import 'button_style.dart';
import 'calendar.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져오기 위해 MediaQuery를 사용합니다.
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: screenWidth * 0.9, // 화면 너비의 90%로 설정
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bmi()),
                  );
                },
                //style: MyButtonStyle.outlinedButtonStyle, // 버튼 스타일 적용
                child: Text('BMI 계산기'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: screenWidth * 0.9, // 화면 너비의 90%로 설정
              child: OutlinedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalendarScreen()),
                  );
                },
                //style: MyButtonStyle.outlinedButtonStyle,
                child: Text('캘린더'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
