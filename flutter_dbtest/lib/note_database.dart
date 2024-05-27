import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NoteDatabase {
  static Future<Database> openDatabaseAndCreate() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path_helper.join(documentsDirectory.path, 'notes.db');

    return openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS notes (
            id INTEGER PRIMARY KEY,
            title TEXT,
            content TEXT
          )
        ''');
      },
    );
  }

  static Future<void> saveNote(String title, String content) async {
    Database database = await openDatabaseAndCreate();

    try {
      await database.insert(
        'notes',
        {'title': title, 'content': content},
      );
    } catch (e) {
      print('Error saving note: $e');
    } finally {
      await database.close();
    }
  }
}

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
              await NoteDatabase.saveNote(_titleController.text, _contentController.text);
              _titleController.clear();
              _contentController.clear();
            },
            child: Text('Save Note'),
          ),
        ],
      ),
    );
  }
}
