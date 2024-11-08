import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Inicialización del databaseFactory para FFI
  Future<Database> get database async {
    if (_database != null) return _database!;
    databaseFactory = databaseFactoryFfi;  // Asegúrate de usar la fábrica FFI
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'rengesspd.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE emergencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        cedula TEXT NOT NULL,
        categoria TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertEmergencia(Map<String, dynamic> emergencia) async {
    Database db = await database;
    return await db.insert('emergencias', emergencia);
  }

  Future<List<Map<String, dynamic>>> getEmergencias() async {
    Database db = await database;
    return await db.query('emergencias');
  }
}

