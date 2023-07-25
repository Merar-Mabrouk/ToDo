// import 'package:flutter/material.dart';
// import 'package:todo/main.dart';

// class SpecialBottomNavBar extends StatefulWidget {
//   const SpecialBottomNavBar({super.key, required this.currentPage, required this.onchanged});
//   final Pages currentPage;
//   final ValueChanged<Pages> onchanged;

//   @override
//   State<SpecialBottomNavBar> createState() => _SpecialBottomNavBarState();
// }

// class _SpecialBottomNavBarState extends State<SpecialBottomNavBar> {
//   var currentindex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: widget.currentPage.index,
//       onTap: (value) => widget.onchanged(Pages.values[value]),
//       items: const [
//         BottomNavigationBarItem(
//             icon: Icon(Icons.line_weight_sharp), label: "To Do"),
//         BottomNavigationBarItem(icon: Icon(Icons.add_task), label: "Add tasks"),
//       ],
//     );
//   }
// }
