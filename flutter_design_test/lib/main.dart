import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: const MainPage(),
      theme: ThemeData(
        useMaterial3: false,  // Flutter에서 Material 3 사용을 비활성화
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),  // 기본 색상 테마를 파란색으로 설정
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> friendList = [
    "Andrew",
    "Brian",
    "Catherine",
    "Wilson",
    "Raul",
    "Daniel",
    "John",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material 3 Design"),  // AppBar에 제목 설정
        centerTitle: true,  // 제목을 가운데로 정렬
      ),
      body: ListView.builder(
          itemCount: friendList.length,  // 친구 목록의 길이만큼 아이템 생성
          itemBuilder: (context, index) {
            return cardContainer(name: friendList[index], number: index + 1);  // 각 친구의 정보를 카드 형태로 출력
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFloatingDialog();  // 플로팅 버튼 클릭 시 다이얼로그 호출
        },
        child: const Icon(Icons.add),  // 플로팅 액션 버튼에 '+' 아이콘 설정
      ),
    );
  }

  // 카드 형태로 친구 정보 표시
  Widget cardContainer({String name = "", int number = 0}) {
    return Card(
      margin: const EdgeInsets.all(10),  // 카드 주변에 여백 설정
      child: ListTile(
        title: Container(
          width: MediaQuery.of(context).size.width,  // 화면 너비만큼 제목 컨테이너 확장
          padding: const EdgeInsets.all(12),  // 내부 여백 설정
          child: Text("$number. $name", style: const TextStyle(fontSize: 20)),  // 친구 이름과 번호 표시
        ),
        subtitle: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("Details"),  // 세부 정보 보기 버튼
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: const Text("Follow"),  // 팔로우 버튼, 톤다운된 스타일 사용
            ),
          ],
        ),
      ),
    );
  }

  // 플로팅 액션 버튼 클릭 시 표시되는 다이얼로그
  void showFloatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,  // 다이얼로그 외부 클릭 시 닫기 허용
      builder: (context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,  // Column 크기를 자식들의 크기에 맞춤
            children: [
              Center(child: Text("Do you want to add a friend?")),  // 다이얼로그에 질문 텍스트 추가
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),  // "No" 버튼 클릭 시 다이얼로그 닫기
              child: const Text("No"),
            ),
            FilledButton(onPressed: () {}, child: const Text("Yes")),  // "Yes" 버튼
          ],
        );
      },
    );
  }
}
