// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themode = ThemeMode.dark;
  ThemeProvider({bool? ig}) {
    if (ig != null) {
      themode = ig ? ThemeMode.dark : ThemeMode.light;
    }
  }
  bool get isDarkmode => themode == ThemeMode.dark;

  void toggle(bool isOn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    themode = isOn ? ThemeMode.dark : ThemeMode.light;
    if (isOn) {
      prefs.setBool("darktheme", true);
    } else
      {prefs.setBool("darktheme", false);} 
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
    cardTheme: const CardTheme(
      color: Colors.white,
      elevation: 1.2,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.redAccent,
      ),
    )),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.redAccent,
        shape: CircleBorder(side: BorderSide.none, eccentricity: 1)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white70,
    ),
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      secondaryContainer: Colors.grey[300],
      tertiaryContainer: Colors.grey[300],
      primaryContainer: Colors.redAccent,
    ),
    iconTheme: const IconThemeData(color: Colors.redAccent, opacity: 0.8),
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: const IconThemeData(color: Colors.redAccent),
      unselectedIconTheme: IconThemeData(color: Colors.redAccent[100]),
      selectedItemColor: Colors.redAccent, // Change the selected item color
      unselectedItemColor:
          Colors.redAccent[100], // Change the unselected item color
    ),
  );
  static final darkTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: Colors.red[700],
      ),
    )),
    cardTheme: const CardTheme(
      color: Colors.black54,
      elevation: 1.2,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black54,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.red[700],
        shape: const CircleBorder(side: BorderSide.none, eccentricity: 1)),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(primaryContainer: Colors.red[700]),
    iconTheme: IconThemeData(color: Colors.red[700], opacity: 0.8),
    useMaterial3: true,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.red[700], // Change the selected item color
      unselectedItemColor: Colors.red[300], // Change the unselected item color
      selectedIconTheme: IconThemeData(color: Colors.red[800]),
      unselectedIconTheme: IconThemeData(color: Colors.red[300]),
    ),
  );
}
