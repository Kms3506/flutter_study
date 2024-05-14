import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildListItem(
            context,
            image: 'flutter.png',
            title: 'Item 1',
            subtitle: 'Test subtitle',
          ),
          _buildListItem(
            context,
            image: 'flutter.png',
            title: 'Item 2',
            subtitle: 'Test subtitle',
          ),
          _buildListItem(
            context,
            image: 'flutter.png',
            title: 'Item 3',
            subtitle: 'Test subtitle',
          ),
          // 추가적인 리스트 아이템들을 필요에 따라 추가할 수 있습니다.
        ],
      ),
    );
  }
 Widget _buildListItem(BuildContext context, {required String image, required String title, required String subtitle}) {
    return ListTile(
      leading: Image.asset(image),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // 해당 목록을 클릭하면 새로운 화면으로 이동합니다.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(title: title),
          ),
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Detail Screen for $title'),
      ),
    );
  }
}