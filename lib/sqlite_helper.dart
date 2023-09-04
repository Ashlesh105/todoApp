import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {

  static Future<sql.Database> db() async{ //create the db
    return sql.openDatabase('tasks.db',version: 1,
        onCreate: (sql.Database database,int version) async{
          await createTable(database);
        });
  }

  static Future<void> createTable(sql.Database database) async { //create a table for task
    await database.execute("""CREATE TABLE tasks(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    taskName TEXT,
    taskDesc Text,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
  }



  static Future<int> addNewTask(String taskName, String taskDesc) async{
    final db = await SQLHelper.db();
    final data ={
      'taskName':taskName,
      'taskDesc':taskDesc,
    };
    final id = await db.insert('task', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getAllTasks() async{
    final db = await SQLHelper.db();
    return db.query('tasks',orderBy: "id");
  }

  static Future<int> updateTask(int id, String taskName, String taskDesc) async{
    final db = await SQLHelper.db();
    final data ={
      'taskName':taskName,
      'taskDesc':taskDesc,
      'createAt': DateTime.now().toString()
    };
    final result = await db.update('tasks', data,where: "id= ?",whereArgs: [id]);
    return result;
  }

  static Future<void> deleteTask(int id) async{
    final db = await SQLHelper.db();
    try{
      await db.delete("tasks",where: "id=?",whereArgs: [id]);
    } catch(err){
      if (kDebugMode) {
        print("something went wrong");
      }
    }
  }
}

