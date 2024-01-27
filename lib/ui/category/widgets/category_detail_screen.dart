import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:third_exam_n8/data/model/product_model.dart';
import 'package:third_exam_n8/data/network/api_repository.dart';
import 'package:third_exam_n8/ui/category/widgets/gridview_widget.dart';

import '../../../data/network/api_provider.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen(
      {super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  List<ProductModel> products = [];
  ApiRepository apiRepository = ApiRepository(apiProvider: ApiProvider());

  List<bool> likedList = [];
  bool isLoading = false;

  _getCategoryData() async {
    setState(() {
      isLoading = true;
    });
    products =
        await apiRepository.fetchProductsByCategory(id: widget.id.toString());
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
        backgroundColor: Colors.black,
        title: Text(
          widget.title,
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
