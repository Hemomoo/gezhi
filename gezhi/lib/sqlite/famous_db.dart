import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableTip = 'tip';
final String columnId = '_id';
final String columnSentence = 'sentence';
final String columnAuthor = 'author';

class Tip {
  late int id;
  late String sentence;
  late String author;

  Tip(this.id, this.sentence, this.author);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnSentence: sentence,
      columnAuthor: author,
    };
    map[columnId] = id;
    return map;
  }

  Tip.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    sentence = map[columnSentence];
    author = map[columnAuthor];
  }
}

class TipSqlite {
  late Database db;

  openSqlite() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    print(databasesPath);
    String path = join(databasesPath, 'geZhi.db');

//根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableTip (
            $columnId INTEGER PRIMARY KEY, 
            $columnSentence TEXT, 
            $columnAuthor TEXT)
          ''');
    });
  }

  // 插入一条书籍数据
  Future<void> insert(Tip tip) async {
    try{
      await db.insert(tableTip, tip.toMap());
    }catch(err){
       print(err);
    }
  }

  // 查找所有书籍信息
  Future<List<Tip>> queryAll() async {
    List<Map> maps = await db.query(tableTip, columns: [
      columnId,
      columnSentence,
      columnAuthor,
    ]);
    if (maps.length == 0) {
      return [];
    }

    List<Tip> tips = [];
    for (int i = 0; i < maps.length; i++) {
      tips.add(Tip.fromMap(Map<String, dynamic>.from(maps[i])));
    }

    return tips;
  }

  // 根据ID查找书籍信息
  Future<Tip?> getBook(int id) async {
    List<Map> maps = await db.query(tableTip,
        columns: [
          columnId,
          columnSentence,
          columnAuthor,
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Tip.fromMap(Map<String, dynamic>.from(maps.first));
    }
    return null;
  }

  // 根据ID删除书籍信息
  Future<int> delete(int id) async {
    return await db.delete(tableTip, where: '$columnId = ?', whereArgs: [id]);
  }

  // 更新书籍信息
  Future<int> update(Tip tip) async {
    return await db.update(tableTip, tip.toMap(),
        where: '$columnId = ?', whereArgs: [tip.id]);
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
  }
}
