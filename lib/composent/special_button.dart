import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/theme/Modes.dart';

bool iss = false;

class SpecialButton extends StatefulWidget {
  const SpecialButton({super.key});

  @override
  State<SpecialButton> createState() => _SpecialButtonState();
}

class _SpecialButtonState extends State<SpecialButton> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      onPressed: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        setState(() {
          iss = !iss;
        });
        provider.toggle(iss);
      },
      icon: Icon(
        themeProvider.isDarkmode ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
