// sqLite 的数据结构

class SqlTable {
  static final String sql_createTable_course = """
    CREATE TABLE course (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    courseId INTEGER NOT NULL UNIQUE, 
    title TEXT NOT NULL, 
    clPublic INTEGER,
    orders INTEGER);
    """;
  static final String sql_createTable_user = """
    CREATE TABLE user (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, 
    uid INTEGER NOT NULL UNIQUE, 
    phone TEXT NOT NULL UNIQUE, 
    nickName TEXT,
    portrait TEXT);
    """;

  /*
  名言
  * @author : 作者
  * @sentence： 名言
  * */

  static final String sql_createTable_famous = '''
    CREATE TABLE famous (
    id INTEGER PRIMARY KEY,
    sentence TEXT,
    author TEXT)
  ''';

  /*
    提示
  * @tip： 提示
  * @date: 日期
  * */

  static final String sql_createTable_tips = '''
    CREATE TABLE tips (
    id INTEGER PRIMARY KEY,
    tip TEXT,
    date TEXT)
  ''';

  /*
  * 日记
  * @tip: 提示
  * @date: 时间
  *
  *
  * */

  static final String sql_createTable_diary = '''
    CREATE TABLE diary (
    id INTEGER PRIMARY KEY,
    tip TEXT,
    date TEXT,
    diaryInfo TEXT
    )
  ''';
}
