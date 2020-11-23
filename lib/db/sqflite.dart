import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBPets {
  static Future<Database> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'pets.db');

// Delete the database
    //await deleteDatabase(path);

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('CREATE TABLE pets (id_pet INTEGER PRIMARY KEY, nome TEXT, imageURL TEXT, descricao TEXT, idade INTEGER, sexo TEXT, cor TEXT, bio TEXT)');
      await db.execute('CREATE TABLE remedios (id INTEGER PRIMARY KEY AUTOINCREMENT,  nome TEXT, data DATETIME, pet INTEGER,FOREIGN KEY (pet) REFERENCES pets (id) ON DELETE NO ACTION  ON UPDATE NO ACTION)');
    });
  }

  static Future<void> insertData(String table, Map<String, Object> dados) async {
    Database _db;
    await _db.insert(table, dados,
        conflictAlgorithm: ConflictAlgorithm.replace);
    getData(table);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    Database _db;
    _db = await openDatabase('pets.db', version: 1);
    List<Map> list = await _db.rawQuery('SELECT * FROM pets');
    return _db.query(table);

  }
}
