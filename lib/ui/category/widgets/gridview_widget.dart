import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:third_exam_n8/data/network/api_repository.dart';
import 'package:third_exam_n8/ui/category/widgets/shimmer_widgets.dart';
import 'package:third_exam_n8/utils/hive_box.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../data/model/product_model.dart';
import '../../../data/network/api_provider.dart';

class GridViewWidget extends StatefulWidget {
  const GridViewWidget({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());

  bool isLoading = false;
  List likedList = [];
  List count = [];

  _getCategoryData() async {
    likedList = List.filled(widget.products.length, false);
    count = List.filled(widget.products.length, 0);
    setState(() {});
  }
  late Box box;
  late Box box2;

  @override
  void initState() {
    box=Hive.box(HiveBox.favorites);
    box2 = Hive.box("shop");
    productsSaved = box2.values.first;
    _getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
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
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
                            imageUrl: widget.products[index].imageUrl,
                            placeholder: (context, url) =>
                                const ShimmerScreen(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                            width: 140.w,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 0.w,
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.white),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              if(!likedList[index]){
                                Fluttertoast.showToast(
                                  msg: "Add to favorites",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                );
                              }else{
                                Fluttertoast.showToast(
                                  msg: "Delete favorites",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                );
                                box.deleteAll(widget.products);
                              }
                              box.put(widget.products[index].id, widget.products[index]);
                              setState(() {
                                likedList[index] = !likedList[index];
                              });
                            },
                            child: Icon(
                              Icons.favorite,
                              color:
                                  likedList[index] ? Colors.red : Colors.grey,
                              size: 25,
                            ),
                          ),
                        ),
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
                        widget.products[index].name,
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          "USD ${widget.products[index].price}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp,
                              color: Colors.blue),
                        ),
                      ),
                      ZoomTapAnimation(
                        onTap: () {
                          count[index]+=1;
                          productsSaved.add({
                            "name":widget.products[index].name,
                            "image_url":widget.products[index].imageUrl,
                            "count":count[index],
                            "price":widget.products[index].price,
                          });
                          Fluttertoast.showToast(
                            msg: "Add to basket",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                          );
                          box2.put("shop",productsSaved);
                        },
                        child: Container(
                          width: 140.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
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
    );
  }
}

List productsSaved = [];

