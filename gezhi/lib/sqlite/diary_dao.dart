import 'package:gezhi/sqlite/init_databasee.dart';

/// 日记本地读写
class DiaryDao {
  static const String tableName = 'diary';

  /// 按日期倒序查询全部日记
  static Future<List<Map<String, dynamic>>> queryAll() async {
    final db = InitDatabase.db;
    if (db == null) return [];
    return db.query(tableName, orderBy: 'date DESC, id DESC');
  }

  static Future<Map<String, dynamic>?> findById(int id) async {
    final db = InitDatabase.db;
    if (db == null) return null;
    final rows =
        await db.query(tableName, where: 'id = ?', whereArgs: [id], limit: 1);
    return rows.isEmpty ? null : rows.first;
  }

  /// 查询某一天最新的一条日记
  static Future<Map<String, dynamic>?> findByDate(String date) async {
    final db = InitDatabase.db;
    if (db == null) return null;
    final rows = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [date],
      orderBy: 'id DESC',
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first;
  }

  static Future<int> insert({
    required String tip,
    required String date,
    required String diaryInfo,
  }) async {
    return InitDatabase.db!.insert(tableName, {
      'tip': tip,
      'date': date,
      'diaryInfo': diaryInfo,
    });
  }

  static Future<int> update({
    required int id,
    required String tip,
    required String date,
    required String diaryInfo,
  }) async {
    return InitDatabase.db!.update(
      tableName,
      {'tip': tip, 'date': date, 'diaryInfo': diaryInfo},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> delete(int id) async {
    return InitDatabase.db!
        .delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
