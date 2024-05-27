import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await saveNote();
              _titleController.clear();
              _contentController.clear();
            },
            child: Text('Save Note'),
          ),
        ],
      ),
    );
  }

  Future<void> saveNote() async {
    // 데이터베이스 열기
    Database database = await openDatabaseAndCreate();
    // 노트 삽입
    await database.insert(
      'notes',
      {
        'title': _titleController.text,
        'content': _contentController.text,
      },
    );
    // 데이터베이스 닫기
    await database.close();
  }

  Future<Database> openDatabaseAndCreate() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path_helper.join(documentsDirectory.path, 'notes.db'); // 변수 이름 변경

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // 데이터베이스 생성 시 실행할 쿼리
        await db.execute('CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT)');
      },
    );
  }
}
