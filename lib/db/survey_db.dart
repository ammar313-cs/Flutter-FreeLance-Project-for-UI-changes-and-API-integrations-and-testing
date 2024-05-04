import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wfm/survey_screen/model/survey_model.dart';
import '';

class SurveyDatabase {
  static final SurveyDatabase instance = SurveyDatabase._init();

  static Database? _database;

  SurveyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('surveyDBV3.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    /*   final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
*/
    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${SurveyFields.id} $idType, 
  ${SurveyFields.long} $textType,
  ${SurveyFields.uid} $textType,
  ${SurveyFields.answer} $textType,
  ${SurveyFields.businesslist} $textType,
  ${SurveyFields.financiallist} $textType,
  ${SurveyFields.geographicList} $textType,
  ${SurveyFields.lat} $textType,
  ${SurveyFields.companyId} $textType,
  ${SurveyFields.imgName} $textType,
  ${SurveyFields.imgStr} $textType,
  ${SurveyFields.qIdList} $textType,
  ${SurveyFields.surveyId} $textType
  )
''');
  }

  Future<SurveyModel> create(SurveyModel note) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<SurveyModel> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: SurveyFields.values,
      where: '${SurveyFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SurveyModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SurveyModel>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${SurveyFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => SurveyModel.fromJson(json)).toList();
  }

  Future<int> update(SurveyModel note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${SurveyFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${SurveyFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
