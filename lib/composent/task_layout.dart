import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/DB/database_tasks.dart';
import 'package:todo/DB/to_do.dart';

class TaskLayout extends StatefulWidget {
  const TaskLayout({super.key, required this.task, required this.dbT});
  final ToDo task;
  final DatabaseTasks dbT;

  @override
  State<TaskLayout> createState() => _TaskLayoutState();
}

class _TaskLayoutState extends State<TaskLayout> {
  bool usable = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(18)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      usable = !usable;
                    });
                  },
                  child: CircleAvatar(
                    maxRadius: 25,
                    child: Icon(
                      usable
                          ? FluentIcons.lightbulb_filament_20_regular
                          : FluentIcons.lightbulb_filament_20_filled,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.task,
                      style: usable
                          ? const TextStyle(
                              fontSize: 21,
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w600)
                          : const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      DateFormat("dd MMM yyyy").format(widget.task.date),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -45,
            top: -40,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.redAccent, width: 16),
              ),
              child: IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlertDialog(
                                surfaceTintColor: Colors.white,
                                title: const Text("delete this task ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(context),
                                      child: const Text("no")),
                                  TextButton(
                                      onPressed: () {
                                        widget.dbT.deleteTodo(widget.task);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("yes")),
                                ],
                              ))),
                  icon: const Icon(Icons.close)),
            ),
          ),
        ],
      ),
    );
  }
}
