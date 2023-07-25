import 'package:flutter/material.dart';
import 'package:todo/DB/database_tasks.dart';
import 'package:todo/DB/to_do.dart';
import 'package:todo/composent/task_layout.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key, required this.dbT}) : super(key: key);
  final DatabaseTasks dbT;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ToDo>>(
      stream: widget.dbT.all(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            if (!snapshot.hasData) {
              return const SliverToBoxAdapter(
                child: Center(
                  child: Text('Error fetching data'),
                ),
              );
            } else {
              final todo = snapshot.data!;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final task = todo[index];
                    return TaskLayout(task: task, dbT: widget.dbT);
                  },
                  childCount: todo.length,
                ),
              );
            }
          default:
            return const CircularProgressIndicator();
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const SliverToBoxAdapter(
        //     child: Center(
        //       child: CircularProgressIndicator(),
        //     ),
        //   );
        // } else if (snapshot.hasError) {
        //   return const SliverToBoxAdapter(
        //     child: Center(
        //       child: Text('Error fetching data'),
        //     ),
        //   );
        // } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //   return const SliverToBoxAdapter(
        //     child: Center(
        //       child: Text('No Tasks.... for now!!'),
        //     ),
        //   );
        // } else {
        //   final todo = snapshot.data!;
        //   return SliverList(
        //     delegate: SliverChildBuilderDelegate(
        //       (context, index) {
        //         final task = todo[index];
        //         return ListTile(
        //           title: Text(task.task),
        //           subtitle: Text(task.description),
        //           // Customize the appearance of the list item here
        //         );
        //       },
        //       childCount: todo.length,
        //     ),
        //   );
        // }
      },
    );
  }
}
