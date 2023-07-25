import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/DB/to_do.dart';

class DatabaseTasks {
  DatabaseTasks({
    required this.dbname,
  });

  final String dbname;
  Database? _db;
  List<ToDo> _tasks = [];
  final StreamController<List<ToDo>> _controller = StreamController.broadcast();

  Future<List<ToDo>> _fetchTask() async {
    final db = _db;
    if (db == null) {
      return [];
    }
    try {
      final read = await db.query("TODO", distinct: true, orderBy: 'id');
      final list = read.map((e) => ToDo.fromDB(e)).toList();
      return list;
    } catch (e) {
      Fluttertoast.showToast(msg: "wash ya chkp : $e");
      return [];
    }
  }

  Future<bool> open() async {
    if (_db != null) {
      return true;
    } else {
      try {
        final db = await openDatabase(dbname);
        _db = db;
        await db.execute(
            " CREATE TABLE IF NOT EXISTS TODO(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT, desc TEXT ,date TEXT)");
        _tasks = await _fetchTask();
        _controller.add(_tasks);
        return true;
      } catch (e) {
        Fluttertoast.showToast(
          msg: "wash a lahbiba : $e",
        );
        return false;
      }
    }
  }

  Future<bool> close() async {
    final db = _db;
    if (db == null) {
      return true;
    }
    try {
      await db.close();
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to close $e");
      return false;
    }
  }

  Stream<List<ToDo>> all() => _controller.stream.map((task) => task..sort());

  Future<bool> createTodo(String task, String desc, DateTime date) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final id = await db.insert("TODO", {
        "task": task,
        "desc": desc,
        "date": DateFormat("dd MMM yyyy").format(date)
      });
      final toDo = ToDo(id: id, task: task, description: desc, date: date);
      _tasks.add(toDo);
      _controller.add(_tasks);
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "homies: $e");
      return false;
    }
  }

  Future<bool> deleteTodo(ToDo sm) async {
    final db = _db;
    if (db == null) {
      return false;
    }
    try {
      final output =
          await db.delete("TODO", where: "id= ?", whereArgs: [sm.id]);
      if(output==1){_tasks.remove(sm);
      _controller.add(_tasks);}
      return true;
    } catch (e) {
      Fluttertoast.showToast(msg: "le :$e");
      return false;
    }
  }
}
