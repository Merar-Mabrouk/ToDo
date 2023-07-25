import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ComposeWidget extends StatefulWidget {
  const ComposeWidget({super.key, required this.function});
  final Function function;
  @override
  State<ComposeWidget> createState() => _ComposeWidgetState();
}

class _ComposeWidgetState extends State<ComposeWidget> {
  final _taskController = TextEditingController();
  final _descController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _taskController.dispose();
    _descController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
          key: _key,
          child: SingleChildScrollView(
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
                        lastDate: DateTime.now().add(const Duration(days: 50)));
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
                FloatingActionButton(onPressed: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  if (_key.currentState!.validate()) {
                    Fluttertoast.showToast(msg: "invalid arguments");
                  } else {
                    widget.function(
                        _key,
                        _taskController.text,
                        _descController.text,
                        DateFormat("dd MMM yyyy").parse(_dateController.text) );
                  }
                  Navigator.pop(context);
                }),
              ],
            ),
          )),
    );
  }
}
