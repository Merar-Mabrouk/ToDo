import 'dart:convert';

import 'package:intl/intl.dart';


List<ToDo> toDoFromJson(String str) =>
    List<ToDo>.from(json.decode(str).map((x) => ToDo.fromJson(x)));

String toDoToJson(List<ToDo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDo implements Comparable {
  ToDo(
      {required this.id,
      required this.task,
      required this.description,
      required this.date});

  int id;
  String task;
  String description;
  DateTime date;

  ToDo.fromDB(Map<String, Object?> data)
      : id = data["id"] as int,
        task = data["task"] as String,
        description = data["desc"] as String,
        date = DateFormat("dd MMM yyyy").parse(data["date"] as String) ;

  @override
  int compareTo(covariant ToDo other) => other.id.compareTo(id);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator == (covariant ToDo other) => id == other.id;

  factory ToDo.fromJson(Map<String, dynamic> json) => ToDo(
        id: json["id"],
        task: json["task"],
        description: json["description"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "description": description,
        "date": date.toIso8601String(),
      };
}
