import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'sql_table.dart';

class InitDatabase {
  static Database db;

  // 获取数据库中所有的表
  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  // 检查数据库中, 表是否完整, 在部份android中, 会出现表丢失的情况
  Future checkTableIsRight() async {
    List<String> expectTables = ['user', 'famous', 'tips', 'diary']; //将项目中使用的表的表名添加集合中

    List<String> tables = await getTables();
    print(tables);
    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables[i])) {
        return false;
      }
    }
    return true;
  }

  //初始化数据库
  Future init() async {
    //Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'gezhi.db');
    print(path);
    try {
      db = await openDatabase(path);
    } catch (e) {
      print("Error $e");
    }

    bool tableIsRight = await this.checkTableIsRight();

    if (!tableIsRight) {
      // 关闭上面打开的db，否则无法执行open
      db.close();
      //表不完整
      // Delete the database
      await deleteDatabase(path);

      db = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(SqlTable.sql_createTable_course);
        await db.execute(SqlTable.sql_createTable_user); // 创建用户数据库
        await db.execute(SqlTable.sql_createTable_famous); // 创建名言数据库
        await db.execute(SqlTable.sql_createTable_tips); // 创建提示的数据
        await db.execute(SqlTable.sql_createTable_diary); // 创建日记数据
        print('db created version is $version');
      }, onOpen: (Database db) async {
        print('new db opened');
      });
    } else {
      print("Opening existing database");
    }
  }
}
