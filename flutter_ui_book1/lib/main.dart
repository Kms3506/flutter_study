import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      home: StringInputScreen(),
    );
  }
}

class StringInputScreen extends StatefulWidget {
  @override
  _StringInputScreenState createState() => _StringInputScreenState();
}

class _StringInputScreenState extends State<StringInputScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _strings = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite String Storage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter a string'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _saveString,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _loadStrings,
                  child: Text('Load'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
              itemCount: _strings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_strings[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveString() async {
    final content = _controller.text;
    if (content.isNotEmpty) {
      await DatabaseHelper.instance.insertString(content);
      _controller.clear();
      _loadStrings();
    }
  }

  Future<void> _loadStrings() async {
    final strings = await DatabaseHelper.instance.fetchStrings();
    setState(() {
      _strings = strings;
    });
  }
}
