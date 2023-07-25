import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/DB/database_tasks.dart';
import 'package:todo/pages/first_page.dart';
import 'package:todo/theme/Modes.dart';
import 'package:todo/composent/special_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});
  final SharedPreferences prefs;
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(ig : prefs.getBool("darktheme")),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TO DO',
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          themeMode: themeProvider.themode,
          home: const MyHomePage(),
        );
      });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final DatabaseTasks tasks;
  final _taskController = TextEditingController();
  final _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
    tasks = DatabaseTasks(dbname: 'Tasks');
    tasks.open();
    super.initState();
  }

  @override
  void dispose() {
    tasks.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "To Do:",
              ),
              titlePadding: EdgeInsets.fromLTRB(29, 35, 10, 5),
            ),
            actions: [
              SpecialButton(),
            ],
          ),
          FirstPage(dbT: tasks),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlertDialog(
              surfaceTintColor: Colors.white,
              scrollable: true,
              title: const Text("Add a task:"),
              content: Form(
                key: _key,
                child: SizedBox(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _taskController,
                        decoration: const InputDecoration(
                          labelText: "Task",
                          enabledBorder: UnderlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "please insert a task" : null,
                      ),
                      TextFormField(
                        controller: _descController,
                        decoration: const InputDecoration(
                          labelText: "give a Description",
                          enabledBorder: UnderlineInputBorder(),
                        ),
                      ),
                      TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                            labelText: "pick the date",
                            enabledBorder: UnderlineInputBorder()),
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 50)));
                          if (date != null) {
                            setState(() {
                              _dateController.text =
                                  DateFormat('dd MMM yyyy').format(date);
                            });
                          }
                        },
                        validator: (value) =>
                            value!.isEmpty ? "please select a date" : null,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("cancel")),
                TextButton(
                    onPressed: () {
                      tasks.createTodo(
                          _taskController.text,
                          _descController.text,
                          DateFormat("dd MMM yyyy")
                              .parse(_dateController.text));
                      Navigator.pop(context);
                    },
                    child: Text("Add")),
              ],
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      // bottomNavigationBar: SpecialBottomNavBar(
      //   currentPage: currentPage,
      //   onchanged: changePage,
      // )
    );
  }
}
