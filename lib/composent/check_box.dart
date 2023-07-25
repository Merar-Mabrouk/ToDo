import 'package:flutter/material.dart';

class SPcheckbox extends StatefulWidget {
  const SPcheckbox({super.key});

  @override
  State<SPcheckbox> createState() => _SPcheckboxState();
}

class _SPcheckboxState extends State<SPcheckbox> {
  bool?  k = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox.adaptive(
        value: k,
        onChanged: (ok) {
         setState(() {
          k = ok;
         });
        });
  }
}
