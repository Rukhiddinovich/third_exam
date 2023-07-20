import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../data/model/product_model.dart';
import '../../utils/hive_box.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool isLoading = false;
  late Box box;
  late Box box2;
  List<ProductModel> products = [];
  var products2;

  @override
  void initState() {
    box = Hive.box(HiveBox.favorites);
    box2 = Hive.box("shop");
    products2 = box2.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Basket",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
              fontSize: 20.sp,
              color: Colors.white),
        ),
        actions: [
          Center(
            child: TextButton(
              child: Text(
                "Clear",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    fontSize: 20.sp,
                    color: Colors.white),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 290.h),
                    child: Dialog(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Text(
                                "Are you sure you want to\ndelete all items in\nyour cart ?",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 18.sp,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.red),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w400,
                                        color: Colors.blue),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 15.w),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            )
          : products2.isEmpty
              ? Center(
                  child: Text(
                    "Not Found",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        fontSize: 20.sp),
                  ),
                )
              : Column(
                  children: [
                    ...List.generate(products2.length, (index) {
                      Map<dynamic, dynamic> productItem = products2[index];
                      return ListTile(
                        title: Text(productItem['name']),
                        subtitle: Text(
                            'Products Count ${productItem['count']} * ${productItem['price']}'),
                        trailing: SizedBox(
                          width: 95.w,
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 50,
                                  height: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: productItem["image_url"],
                                    fit: BoxFit.cover,
                                  )),
                              IconButton(
                                onPressed: () {
                                  products.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.h, vertical: 20.h),
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 0.r,
                                blurRadius: 7.r,
                                offset: Offset.zero)
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15.w),
                            Text(
                              "Total sum",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.sp,
                                  fontFamily: "Inter",
                                  color: Colors.black),
                            ),
                            SizedBox(width: 20.w),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              size: 50.sp,
                            ),
                            SizedBox(width: 50.w),
                            Text(
                              "\$ 0",
                              style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
