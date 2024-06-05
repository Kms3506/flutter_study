import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'class/list1.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'list1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE list1(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            content TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertListItem(ListItem1 listItem) async {
    Database db = await database;
    return await db.insert('list1', listItem.toMap());
  }

  Future<List<ListItem1>> getListItems() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('list1');
    return List.generate(maps.length, (index) {
      return ListItem1(
        id: maps[index]['id'],
        content: maps[index]['content'],
      );
    });
  }

  Future<void> updateListItem(ListItem1 listItem) async {
    Database db = await database;
    await db.update(
      'list1',
      listItem.toMap(),
      where: 'id = ?',
      whereArgs: [listItem.id],
    );
  }

  Future<void> deleteListItem(int id) async {
    Database db = await database;
    await db.delete(
      'list1',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
