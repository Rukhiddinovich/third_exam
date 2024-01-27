import 'package:flutter/cupertino.dart';
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
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentScreenIndex = index;
            });
          },
          currentIndex: currentScreenIndex,
          unselectedIconTheme: const IconThemeData(color: Colors.white),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          items:  [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.rectangle_3_offgrid),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.rectangle_grid_2x2),
                label: "Products"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.shopping_cart),
                label: "Basket"),
          ],
        ),
      ),
    );
  }
}
