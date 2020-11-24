import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(path.join(dbPath, 'pets.db'),
        onCreate: (db, version) {
      _createDb(db);
    }, version: 1);
  }

  static void _createDb(sql.Database db) async {
    db.execute(''' 
              CREATE TABLE pets (id_pet INTEGER PRIMARY KEY,
              nome TEXT, imageURL TEXT, descricao TEXT,
              idade INTEGER, sexo TEXT,
              cor TEXT, bio TEXT)
          ''');
    db.execute("""CREATE TABLE remedios (id INTEGER PRIMARY KEY AUTOINCREMENT, 
    nome TEXT, data DATETIME, hora TEXT, pet INTEGER,
    FOREIGN KEY (pet) REFERENCES pets (id_pet) ON DELETE NO ACTION 
    ON UPDATE NO ACTION)""");
  }

  static Future<void> insertData(
      String table, Map<String, Object> dados) async {
    final db = await database();
    await db.insert(table, dados,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> updteData(String table, Map<String, Object> dados,
      String whereString, List<dynamic> whereArgumento) async {
    final db = await database();
    await db.update(table, dados,
        where: whereString, whereArgs: whereArgumento);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getDataWhere(
      String table,
      List<String> colunas,
      String whereString,
      List<dynamic> whereArgumento) async {
    final db = await database();
    return db.query(table,
        columns: colunas, where: whereString, whereArgs: whereArgumento);
  }
}
