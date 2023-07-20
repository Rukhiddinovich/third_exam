import 'package:flutter/material.dart';
import 'package:third_exam_n8/ui/market/market_screen.dart';
import 'package:third_exam_n8/ui/product/product_screen.dart';
import 'category/category_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentScreenIndex = 0;
  List<dynamic> screens = [
    const CategoryScreen(),
    const ProductScreen(),
    const MarketScreen(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreenIndex],
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentScreenIndex = index;
            });
          },
          currentIndex: currentScreenIndex,
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.rectangle_rounded),
                label: "Products"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: "Basket"),
          ],
        ),
      ),
    );
  }
}
