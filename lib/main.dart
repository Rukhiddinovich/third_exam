import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:third_exam_n8/data/model/product_model.dart';
import 'package:third_exam_n8/data/model/shop_model.dart';
import 'package:third_exam_n8/ui/app_routes.dart';
import 'package:third_exam_n8/ui/tabs_box.dart';
import 'package:third_exam_n8/utils/hive_box.dart';


Future<void> main()async {

  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ShopModelAdapter());
  await Hive.openBox(HiveBox.shop);
  await Hive.openBox('shop');
  await Hive.openBox(HiveBox.favorites);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {

        return MaterialApp(
          theme: ThemeData(
            fontFamily: "Inter",
            scaffoldBackgroundColor: Colors.black,
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (BuildContext context) => IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: Icon(CupertinoIcons.back, color: Colors.white),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          home: TabBox(),
        );
      },
    );
  }
}