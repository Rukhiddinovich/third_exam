// import 'package:default_project/ui/favorite/favorite_screen.dart';
// import 'package:default_project/ui/korzin/korzin_screen.dart';
// import 'package:default_project/ui/profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'home/home_screen.dart';
//
// class TabBox extends StatefulWidget {
//   const TabBox({super.key});
//
//   @override
//   State<TabBox> createState() => _TabBoxState();
// }
//
// class _TabBoxState extends State<TabBox> {
//   int currentScreenIndex = 0;
//   List<dynamic> screens = [
//     const HomeScreen(),
//     const KorzinScreen(),
//     const FavoriteScreen(index: 0),
//     const ProfileScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[currentScreenIndex],
//       bottomNavigationBar: ClipRRect(
//         borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(16), topRight: Radius.circular(16)),
//         child: BottomNavigationBar(
//           backgroundColor: Colors.blueAccent,
//           type: BottomNavigationBarType.fixed,
//           onTap: (index) {
//             setState(() {
//               currentScreenIndex = index;
//             });
//           },
//           currentIndex: currentScreenIndex,
//           selectedItemColor: Colors.yellowAccent,
//           unselectedItemColor: Colors.white,
//           selectedIconTheme: const IconThemeData(color: Colors.yellow),
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
//             BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,), label: ""),
//             BottomNavigationBarItem(icon: Icon(Icons.favorite,), label: ""),
//             BottomNavigationBarItem(icon: Icon(Icons.person,), label: ""),
//           ],
//         ),
//       ),
//     );
//   }
// }
