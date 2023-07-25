import 'package:flutter/material.dart';
import 'package:todo/composent/compose_view.dart';


class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.fu});
  final Function fu;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return  SliverToBoxAdapter(
      child: ComposeWidget(function: widget.fu
      )
    );
  }
}