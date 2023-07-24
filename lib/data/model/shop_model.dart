import 'package:hive/hive.dart';
import 'package:third_exam_n8/data/model/product_model.dart';

part 'shop_model.g.dart';

@HiveType(typeId: 2)
class ShopModel extends HiveObject {
  @HiveField(0)
  ProductModel product;

  @HiveField(1)
  int count;

  ShopModel({
    required this.product,
    required this.count,
  });
}
