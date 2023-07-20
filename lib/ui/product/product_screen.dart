import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/model/product_model.dart';
import 'package:third_exam_n8/data/network/api_repository.dart';
import 'package:third_exam_n8/ui/app_routes.dart';

import '../../../data/network/api_provider.dart';
import '../category/widgets/gridview_widget.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductModel> products = [];
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());

  bool isLoading = false;
  List<bool> likedList = [];

  _getCategoryData() async {
    setState(() {
      isLoading = true;
    });
    products = await apiRepository.fetchAllProducts();
    likedList = List<bool>.filled(products.length, false);

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
        backgroundColor: Colors.blue,
        title: Text(
          "Products",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: "Inter",
              fontSize: 20.sp,
              color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.favoriteScreen);
              },
              icon: Icon(Icons.favorite, size: 25.sp)),
          SizedBox(width: 15.w)
        ],
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
              : GridViewWidget(products: products),
    );
  }
}
