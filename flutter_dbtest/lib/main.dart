import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'database_helper.dart';

void main() {
  // FFI 초기화
  sqfliteFfiInit();
  // databaseFactory 설정
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Memo Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _memoController = TextEditingController();
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _memoController,
                      decoration: InputDecoration(labelText: 'Enter Memo'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String memoText = _memoController.text;
                        String date = DateTime.now().toIso8601String();
                        await dbHelper.insertMemo(date, memoText);
                        _memoController.clear();
                        setState(() {});
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: dbHelper.getAllMemos(),
              builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No memos found'));
                } else {
                  List<Map<String, dynamic>> memos = snapshot.data!;
                  return ListView.builder(
                    itemCount: memos.length,
                    itemBuilder: (context, index) {
                      String memoText = memos[index]['memo'];
                      String date = memos[index]['date'];
                      return ListTile(
                        title: Text(memoText),
                        subtitle: Text(date),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
