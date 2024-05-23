import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// 이 줄을 추가합니다.
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init() {
    // 데스크톱 환경에서 실행할 때 sqflite_common_ffi를 초기화합니다.
    if (isFfiEnabled) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  // 데스크톱 환경을 감지하는 플래그를 추가합니다.
  bool get isFfiEnabled => !identical(0, 0.0); // 단순히 데스크톱 환경을 감지합니다.

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('example.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE strings(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL
)
''');
  }

  Future<void> insertString(String content) async {
    final db = await instance.database;

    await db.insert(
      'strings',
      {'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> fetchStrings() async {
    final db = await instance.database;

    final result = await db.query('strings');

    return result.map((row) => row['content'] as String).toList();
  }
}
