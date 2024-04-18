import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'TableEnum.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'awe-local.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
      await db.execute('''
      CREATE TABLE ${toString(TableName.ArtworkScanned)} (
        id INTEGER PRIMARY KEY,
        artwork_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        location TEXT,
        image_url TEXT,
        unlocked INTEGER DEFAULT 0
      );
    ''');

      await db.execute('''
      CREATE TABLE ${toString(TableName.Tag)} (
        id INTEGER PRIMARY KEY,
        tag TEXT NOT NULL
      );
    ''');

      await db.execute('''
      CREATE TABLE ${toString(TableName.ArtworkTag)} (
        id INTEGER PRIMARY KEY,
        artwork_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        FOREIGN KEY (artwork_id) REFERENCES Artwork_Scanned(id),
        FOREIGN KEY (tag_id) REFERENCES Tag(id),
        UNIQUE(artwork_id, tag_id)
      );
    ''');
      print("Tables created");
  }

  Future<void> insertData(TableName tableName,Map<String, dynamic> data) async {
    final db = await database;
    await db.insert(toString(tableName), data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertAllData(TableName tableName, List<Map<String, dynamic>> dataList) async {
    final db = await database;
    Batch batch = db.batch();
    for (Map<String, dynamic> data in dataList) {
      batch.insert(toString(tableName), data, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAllData(TableName tableName, {int? id}) async {
    final db = await database;

    if (id != null) {
      switch (tableName) {
        case TableName.ArtworkScanned:
          return await db.query(
            toString(tableName),
            where: 'artwork_id = ?',
            whereArgs: [id],
          );
        case TableName.Tag:
          return await db.query(
            toString(tableName),
            where: 'id = ?',
            whereArgs: [id],
          );
        case TableName.ArtworkTag:
          return await db.query(
            toString(tableName),
            where: 'tag_id = ?',
            whereArgs: [id],
          );
        default:
          break;
      }
    }
    return await db.query(toString(tableName));
  }


  Future<void> updateData(TableName tableName, Map<String, dynamic> data) async {
    final db = await database;
    await db.update(toString(tableName), data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<void> deleteData(TableName tableName,int id) async {
    final db = await database;
    await db.delete(toString(tableName), where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> isArtworkIdExists(int artworkId) async {
    final db = await database;
    var result = await db.query(
      toString(TableName.ArtworkScanned),
      where: 'artwork_id = ?',
      whereArgs: [artworkId],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
