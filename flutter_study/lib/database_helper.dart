import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// 일반화된 데이터베이스 헬퍼 클래스
class DatabaseHelper {
  static Database _database;
  static const String dbName = 'your_database.db'; // 데이터베이스 파일명

  // 데이터베이스 연결 확인 및 초기화
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initializeDatabase();
    return _database;
  }

  // 데이터베이스 초기화
  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  // 데이터베이스 생성 쿼리
  Future<void> _createDatabase(Database db, int version) async {
    // 각 테이블의 생성 쿼리 호출
    await db.execute('''
      CREATE TABLE IF NOT EXISTS table1 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // table1의 필드 정의
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS table2 (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        // table2의 필드 정의
      )
    ''');

    // 이하 추가 테이블에 대한 생성 쿼리도 추가
  }

  // 테이블에 데이터 추가
  Future<int> insertData(String table, Map<String, dynamic> data) async {
    Database db = await this.database;
    return await db.insert(table, data);
  }

  // 테이블에서 모든 데이터 가져오기
  Future<List<Map<String, dynamic>>> getAllData(String table) async {
    Database db = await this.database;
    return await db.query(table);
  }

  // 테이블에서 특정 데이터 가져오기
  Future<Map<String, dynamic>> getDataById(String table, int id) async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query(table, where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // 테이블의 데이터 수정
  Future<int> updateData(String table, Map<String, dynamic> data) async {
    Database db = await this.database;
    int id = data['id'];
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // 테이블에서 특정 데이터 삭제
  Future<int> deleteData(String table, int id) async {
    Database db = await this.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  // 데이터베이스 닫기
  Future<void> closeDatabase() async {
    Database db = await this.database;
    db.close();
  }
}
