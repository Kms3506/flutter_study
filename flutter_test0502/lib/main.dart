import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App with Header and Buttons',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Header Title'), // 헤더에 표시될 제목
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 버튼이 눌렸을 때 수행할 동작
                  print('Button 1 pressed');
                },
                child: Text('Button 1'), // 버튼 텍스트
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 버튼이 눌렸을 때 수행할 동작
                  print('Button 2 pressed');
                },
                child: Text('Button 2'), // 버튼 텍스트
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 버튼이 눌렸을 때 수행할 동작
                  print('Button 3 pressed');
                },
                child: Text('Button 3'), // 버튼 텍스트
              ),
            ],
          ),
        ),
      ),
    );
  }
}
