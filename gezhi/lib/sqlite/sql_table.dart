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

  static final String sql_createTable_famous = '''
    CREATE TABLE famous (
    id INTEGER PRIMARY KEY,
    sentence TEXT,
    author TEXT)
  ''';

  static final String sql_createTable_tips = '''
    CREATE TABLE tips (
    id INTEGER PRIMARY KEY,
    tip TEXT,
    date TEXT)
  ''';

  static final String sql_createTable_diary = '''
    CREATE TABLE diary (
    id INTEGER PRIMARY KEY,
    tip TEXT,
    date TEXT)
  ''';

}
