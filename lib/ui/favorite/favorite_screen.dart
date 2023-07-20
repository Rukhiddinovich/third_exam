import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/model/product_model.dart';
import '../../utils/hive_box.dart';
import '../category/widgets/shimmer_widgets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<ProductModel> products = [];

  late Box box;

  @override
  void initState() {
    box = Hive.box(HiveBox.favorites);
    products = box.values.toList().map((e) => e as ProductModel).toList();
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Favorites",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
              fontSize: 20.sp,
              color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : products.isEmpty
              ? Center(
                  child: Text(
                    "Not Found",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 20.sp),
                  ),
                )
              : GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.w,
                      crossAxisSpacing: 10.h,
                      childAspectRatio: 0.58),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1.r,
                                blurRadius: 10.r,
                                offset: Offset.zero)
                          ],
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: SizedBox(
                                    height: 120.h,
                                    child: CachedNetworkImage(
                                        imageUrl: products[index].imageUrl,
                                        placeholder: (context, url) =>
                                            const ShimmerScreen(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error,
                                                color: Colors.red),
                                        width: 140.w,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    products[index].name,
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20.h),
                                    child: Text(
                                      "USD ${products[index].price}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 22.sp,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  ZoomTapAnimation(
                                    onTap: () {},
                                    child: Container(
                                      width: 140.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          color: Colors.black),
                                      child: Center(
                                        child: Text(
                                          "Add to basket",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
