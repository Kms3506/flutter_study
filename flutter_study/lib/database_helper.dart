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
        await db.execute('''
          CREATE TABLE memos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            memo TEXT
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
  // 메모 추가 함수
  Future<void> insertMemo(String date, String memo) async {
    final db = await database;
    try {
      await db.insert(
        'memos',
        {'date': date, 'memo': memo},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // 에러 처리
      throw Exception('Insert memo failed: $e');
    }
  }

  // 메모 업데이트 함수
  Future<void> updateMemo(String date, String memo) async {
    final db = await database;
    try {
      await db.update(
        'memos',
        {'memo': memo},
        where: 'date = ?',
        whereArgs: [date],
      );
    } catch (e) {
      // 에러 처리
      throw Exception('Update memo failed: $e');
    }
  }

  // 특정 날짜의 메모 가져오기 함수
  Future<String?> getMemo(String date) async {
    final db = await database;
    try {
      List<Map<String, dynamic>> maps = await db.query(
        'memos',
        where: 'date = ?',
        whereArgs: [date],
      );
      if (maps.isNotEmpty) {
        return maps.first['memo'] as String?;
      }
      return null;
    } catch (e) {
      // 에러 처리
      throw Exception('Get memo failed: $e');
    }
  }

  // 데이터베이스 연결 닫기
  Future<void> close() async {
    final db = await database;
    try {
      await db.close();
    } catch (e) {
      // 에러 처리
      throw Exception('Close database failed: $e');
    }
  }
}
  

