import 'dart:async'; // Importing async library for asynchronous operations
import 'package:path/path.dart'; // Importing path library for path manipulation
import 'package:sqflite/sqflite.dart'; // Importing sqflite library for SQLite operations
import 'TableEnum.dart'; // Importing TableEnum for table names

class DatabaseHelper {
  static DatabaseHelper? _instance; // Singleton instance of DatabaseHelper
  static Database? _database; // SQLite database instance

  DatabaseHelper._privateConstructor(); // Private constructor to prevent external instantiation

  // Factory constructor to return the singleton instance of DatabaseHelper
  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  // Getter to retrieve the SQLite database instance
  Future<Database> get database async {
    if (_database != null)
      return _database!; // Return existing database instance if available
    _database =
        await _initDatabase(); // Initialize the database if not already initialized
    return _database!; // Return the initialized database instance
  }

  // Method to initialize the SQLite database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(),
        'awe-local.db'); // Construct the database path
    return await openDatabase(path,
        version: 1, onCreate: _createDatabase); // Open the database
  }

  // Method to create database tables
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
    '''); // Create ArtworkScanned table

    await db.execute('''
      CREATE TABLE ${toString(TableName.Tag)} (
        id INTEGER PRIMARY KEY,
        tag TEXT NOT NULL
      );
    '''); // Create Tag table

    await db.execute('''
      CREATE TABLE ${toString(TableName.ArtworkTag)} (
        id INTEGER PRIMARY KEY,
        artwork_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL,
        FOREIGN KEY (artwork_id) REFERENCES Artwork_Scanned(id),
        FOREIGN KEY (tag_id) REFERENCES Tag(id),
        UNIQUE(artwork_id, tag_id)
      );
    '''); // Create ArtworkTag table
    print("Tables created"); // Print message confirming table creation
  }

  // Method to insert data into a table
  Future<void> insertData(
      TableName tableName, Map<String, dynamic> data) async {
    final db = await database; // Get the database instance
    await db.insert(toString(tableName), data,
        conflictAlgorithm:
            ConflictAlgorithm.replace); // Insert data into the specified table
  }

  // Method to insert multiple data entries into a table
  Future<void> insertAllData(
      TableName tableName, List<Map<String, dynamic>> dataList) async {
    final db = await database; // Get the database instance
    Batch batch = db.batch(); // Create a batch operation
    for (Map<String, dynamic> data in dataList) {
      batch.insert(toString(tableName), data,
          conflictAlgorithm: ConflictAlgorithm
              .replace); // Add each data entry to the batch operation
    }
    await batch.commit(noResult: true); // Execute the batch operation
  }

  // Method to retrieve all data from a table
  Future<List<Map<String, dynamic>>> getAllData(TableName tableName) async {
    final db = await database; // Get the database instance
    return await db
        .query(toString(tableName)); // Query all data from the specified table
  }

  // Method to update data in a table
  Future<void> updateData(
      TableName tableName, Map<String, dynamic> data) async {
    final db = await database; // Get the database instance
    await db.update(toString(tableName), data, where: 'id = ?', whereArgs: [
      data['id']
    ]); // Update data in the specified table based on the provided condition
  }

  // Method to delete data from a table
  Future<void> deleteData(TableName tableName, int id) async {
    final db = await database; // Get the database instance
    await db.delete(toString(tableName), where: 'id = ?', whereArgs: [
      id
    ]); // Delete data from the specified table based on the provided condition
  }

  // Method to check if an artwork ID exists in the ArtworkScanned table
  Future<bool> isArtworkIdExists(int artworkId) async {
    final db = await database; // Get the database instance
    var result = await db.query(
      toString(TableName.ArtworkScanned),
      where: 'artwork_id = ?',
      whereArgs: [artworkId],
      limit: 1,
    ); // Query the ArtworkScanned table to check if the artwork ID exists
    return result
        .isNotEmpty; // Return true if the result is not empty, indicating that the artwork ID exists
  }
}
