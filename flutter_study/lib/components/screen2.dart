import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _buildListItem(
            image: 'flutter.png',
            title: 'Item 1',
            subtitle: 'Description for Item 4',
          ),
          _buildListItem(
            image: 'flutter.png',
            title: 'Item 2',
            subtitle: 'Description for Item 5',
          ),
          _buildListItem(
            image: 'flutter.png',
            title: 'Item 3',
            subtitle: 'Description for Item 6',
          ),
          // 추가적인 리스트 아이템들을 필요에 따라 추가할 수 있습니다.
        ],
      ),
    );
  }

  Widget _buildListItem({required String image, required String title, required String subtitle}) {
    return ListTile(
      leading: Image.asset(image),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        // 항목을 탭할 때 수행할 작업을 여기에 추가하세요.
      },
    );
  }
}
