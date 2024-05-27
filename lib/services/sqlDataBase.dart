// ignore: file_names
import 'package:liste_elements/models/liste_element.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class CruddataBase {
  late final Database _database;
  Future<void> openDb() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, "element.db");
    _database = await openDatabase(path, version: 1, onCreate: _CreateDb);
  }

 // ignore: non_constant_identifier_names
 Future<void> _CreateDb(Database db, int version) async {
  await db.execute('''
CREATE TABLE liste_element(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nom TEXT NOT NULL,
  description TEXT NOT NULL
)
''');
}


  // ignore: non_constant_identifier_names
  Future<int> insertElement(ListeElement ListeElement) async {
    await openDb();
    return await _database.insert('liste_element', ListeElement.toMap());
  }

  // ignore: non_constant_identifier_names
  Future<void> updateElement(ListeElement ListeElement) async {
    await openDb();
    await _database.update('liste_element', ListeElement.toMap(),
        where: 'id = ?', whereArgs: [ListeElement.id]);
  }

  Future<void> deleteElement(int id) async {
    await openDb();
    await _database.delete('liste_element', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ListeElement>> getListeElement() async {
    await openDb();

    final List<Map<String, dynamic>> maps =
        await _database.query('liste_element');

    return List.generate(maps.length, (i) {
      return ListeElement(
          id: maps[i]['id'], nom: maps[i]['nom'], description: maps[i]['description']);
    });
  }

  Future<ListeElement?> getElementWithId(int id) async {
    await openDb();
    final List<Map<String, dynamic>> maps =
        await _database.query("liste_element", where: "id = ?", whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ListeElement(
          id: maps[0]['id'], nom: maps[0]['nom'], description: maps[0]['description']);
    } else {
      return null;
    }
  }
}
