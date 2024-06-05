import 'package:flutter/material.dart';
//import 'button_style.dart';
import '../class/list1.dart';
import '../database_helper.dart';

class Memo extends StatefulWidget {
  final String title;

  const Memo({Key? key, required this.title}) : super(key: key);

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<Memo> {
  late Future<List<ListItem1>> listItems;
  final TextEditingController _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    listItems = DatabaseHelper().getListItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _memoController,
                    maxLines: null,
                    onChanged: (text) {},
                    decoration: InputDecoration(
                      // hintText: '메모를 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _saveMemo(_memoController.text);
                  },
                  //style: MyButtonStyle.outlinedButtonStyle,
                  child: Text('저장'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: FutureBuilder<List<ListItem1>>(
                future: listItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<ListItem1> listItemList = snapshot.data!;
                    return ListView.builder(
                      itemCount: listItemList.length,
                      itemBuilder: (context, index) {
                        final listItem = listItemList[index];
                        return ListTile(
                          title: Text(listItem.content),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _editMemo(listItem);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteMemo(listItem);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveMemo(String memo) async {
    if (memo.isNotEmpty) {
      await DatabaseHelper().insertListItem(ListItem1(content: memo));
      _memoController.clear();
      setState(() {
        listItems = DatabaseHelper().getListItems();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('메모가 저장되었습니다.'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('메모를 입력하세요.'),
      ));
    }
  }

  void _editMemo(ListItem1 listItem) async {
    _memoController.text = listItem.content;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('메모 수정'),
        content: TextField(
          controller: _memoController,
          // decoration: InputDecoration(hintText: '메모를 수정하세요...'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_memoController.text.isNotEmpty) {
                listItem.content = _memoController.text;
                await DatabaseHelper().updateListItem(listItem);
                setState(() {
                  listItems = DatabaseHelper().getListItems();
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('메모가 수정되었습니다.'),
                ));
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('메모를 입력하세요.'),
                ));
              }
            },
            child: Text('저장'),
          ),
        ],
      ),
    );
  }

  void _deleteMemo(ListItem1 listItem) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('메모 삭제'),
        content: Text('이 메모를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () async {
              await DatabaseHelper().deleteListItem(listItem.id!);
              setState(() {
                listItems = DatabaseHelper().getListItems();
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('메모가 삭제되었습니다.'),
              ));
              Navigator.pop(context);
            },
            child: Text('삭제'),
          ),
        ],
      ),
    );
  }
}
