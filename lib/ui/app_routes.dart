import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:third_exam_n8/ui/category/widgets/category_detail_screen.dart';
import 'package:third_exam_n8/ui/favorite/favorite_screen.dart';

class RouteNames {
  static const String categoryDetail = "categoryDetail";
  static const String favoriteScreen = "favoriteScreen";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.favoriteScreen:
        return CupertinoPageRoute(builder: (context) => const FavoriteScreen());
      case RouteNames.categoryDetail:
        return CupertinoPageRoute(builder: (context) {
          Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
          return CategoryDetailScreen(id: map["id"], title: map["title"]);
        });
      default:
        return CupertinoPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text("Route not found!")),
          ),
        );
    }
  }
}
