import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String registerTable = 'registerTable';
final String idColumn = 'idColumn';
final String nameColumn = 'nameColumn';
final String dataColumn = 'dataColumn';
final String atendColumn = 'atendColumn';
final String horaColumn = 'horaColumn';
final String valorColmn = 'valorColumn';

class RegisterHelper {
  static final RegisterHelper _instance = RegisterHelper.internal();

  factory RegisterHelper() => _instance;

  RegisterHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'registernew.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          'CREATE TABLE $registerTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dataColumn TEXT,'
          '$atendColumn TEXT, $horaColumn TEXT, $valorColmn TEXT)');
    });
  }

  Future<Register> saveRegister(Register register) async {
    Database dbRegister = await db;
    register.id = await dbRegister.insert(registerTable, register.toMap());
    return register;
  }

  Future<Register> getRegister(int id) async {
    Database dbRegister = await db;
    List<Map> maps = await dbRegister.query(registerTable,
        columns: [
          idColumn,
          nameColumn,
          dataColumn,
          atendColumn,
          horaColumn,
          valorColmn
        ],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Register.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteRegister(int id) async {
    Database dbRegister = await db;
    return await dbRegister
        .delete(registerTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateRegister(Register register) async {
    Database dbRegister = await db;
    return await dbRegister.update(registerTable, register.toMap(),
        where: '$idColumn = ?', whereArgs: [register.id]);
  }

  Future<List> getAllRegisters() async {
    Database dbRegister = await db;
    List listMap = await dbRegister.rawQuery('SELECT * FROM $registerTable');
    List<Register> listRegister = List();
    for (Map m in listMap) {
      listRegister.add(Register.fromMap(m));
    }
    return listRegister;
  }

  Future<int> getNumber() async {
    Database dbRegister = await db;
    return Sqflite.firstIntValue(
        await dbRegister.rawQuery('SELECT CONT(*) FROM $registerTable'));
  }

  Future close() async {
    Database dbRegister = await db;
    dbRegister.close();
  }
}

class Register {
  int id;
  String name;
  String data;
  String atend;
  String hora;
  String valor;

  Register();

  Register.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    data = map[dataColumn];
    atend = map[atendColumn];
    hora = map[horaColumn];
    valor = map[valorColmn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      dataColumn: data,
      atendColumn: atend,
      horaColumn: hora,
      valorColmn: valor
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Register(id: $id, name: $name, data: $data, atend: $atend, hora: $hora, valor: $valor)";
  }
}
