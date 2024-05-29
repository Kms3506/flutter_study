import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'components/screen1.dart';
import 'components/screen2.dart';
import 'components/screen3.dart';
import 'components/loading_screen.dart'; // 로딩 화면 파일 임포트

void main() {
  initializeDateFormatting('ko_KR', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Example',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue, // AppBar의 색상 변경
        ),
      ),
      home: LoadingToMainScreen(), // 로딩 화면으로 설정
    );
  }
}

class LoadingToMainScreen extends StatefulWidget {
  @override
  _LoadingToMainScreenState createState() => _LoadingToMainScreenState();
}

class _LoadingToMainScreenState extends State<LoadingToMainScreen> {
  bool _isLoading = true; // 로딩 상태를 나타내는 변수

  @override
  void initState() {
    super.initState();
    // 로딩이 완료된 후 2초 후에 메인 앱 화면으로 이동
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 로딩 중이면 로딩 화면을, 로딩이 완료되면 메인 앱 화면을 보여줌
    return _isLoading ? LoadingScreen() : MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Screen1(),
    Screen2(),
    Screen3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Example'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
