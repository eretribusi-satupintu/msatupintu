import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const tagihanTable = 'tagihan';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  late Database _database;

  Future<Database> get database async {
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "satupintu_local.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE $tagihanTable ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "petugas_id INTEGER, "
        "tagihan_id INTEGER, "
        "sub_wilayah_id INTEGER, "
        "tagihan_name TEXT, "
        "wajib_retribusi_name TEXT, "
        "price INTEGER, "
        "subwilayah TEXT, "
        "due_date TEXT, "
        "status INT"
        ")");
  }
}
