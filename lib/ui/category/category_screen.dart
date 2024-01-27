import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/model/category_model.dart';
import 'package:third_exam_n8/data/universal_response.dart';
import 'package:third_exam_n8/ui/app_routes.dart';
import 'package:third_exam_n8/ui/category/widgets/shimmer_widgets.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/network/api_provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategoryModel> categoryModels = [];

  bool isLoading = false;

  _getCategoryData() async {
    setState(() {
      isLoading = true;
    });
    List<UniversalResponse> result =
        await Future.wait([ApiProvider().getAllCategories()]);

    if (result[0].error.isEmpty) {
      categoryModels = result.first.data as List<CategoryModel>;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "List of categories",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
              fontSize: 20.sp,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
          : categoryModels.isEmpty
              ? Center(
                  child: Text(
                    "Not Found",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 20.sp),
                  ),
                )
              : ListView(
                  children: [
                    SizedBox(height: 10.h),
                    ...List.generate(
                      categoryModels.length,
                      (index) {
                        return Column(
                          children: [
                            ZoomTapAnimation(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.categoryDetail,
                                    arguments: {
                                      "id": categoryModels[index].id,
                                      "title": categoryModels[index].name
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                height: 105.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 1.r,
                                        blurRadius: 10.r,
                                        offset: Offset.zero)
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                        imageUrl:
                                            categoryModels[index].imageUrl,
                                        width: 150.w,
                                        placeholder: (context, url) =>
                                            const ShimmerScreen()),
                                    SizedBox(width: 40.w),
                                    Text(
                                      categoryModels[index].name,
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}
