import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

import '../../data/model/product_model.dart';
import '../category/widgets/gridview_widget.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late Box box;
  dynamic sum = 0;
  List<ProductModel> products = [];

  bool isLoading = true;

  _calculate() {
    sum = 0;
    productsSaved.map((e) => e['count'] * e['price']).forEach((element) {
      sum += element;
    });
  }

  @override
  void initState() {
    _calculate();
    // box = Hive.box("saved");
    // productsHive = box.values;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop',
          style: TextStyle(
              fontFamily: "Inter",
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                ...List.generate(
                  productsSaved.length,
                  (index) {
                    Map<String, dynamic> currency1 = productsSaved[index];
                    return ListTile(
                      title: Text(currency1['name']),
                      subtitle: Text(
                          'Products Count ${currency1['count']} * ${currency1['price']}'),
                      trailing: SizedBox(
                        width: 100.w,
                        child: Row(
                          children: [
                            SizedBox(
                                width: 50.w,
                                height: 100.h,
                                child: CachedNetworkImage(
                                  imageUrl: currency1["image_url"],
                                  fit: BoxFit.cover,
                                )),
                            IconButton(
                              onPressed: () {
                                productsSaved.removeAt(index);
                                setState(() {
                                  _calculate();
                                });
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
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10.r)]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price ',
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    const Icon(
                      Icons.arrow_right_alt_sharp,
                      size: 60,
                    ),
                    Text(
                      '\$$sum',
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
