import 'package:hive/hive.dart';
part 'product_model.g.dart';
@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final num categoryId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final num price;
  @HiveField(4)
  final String imageUrl;


  ProductModel(
      {required this.imageUrl,
      required this.id,
      required this.name,
      required this.price,
      required this.categoryId});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      imageUrl: json["image_url"] as String? ?? "",
      id: json["id"] as num? ?? 0,
      name: json["name"] as String? ?? "",
      price: json["price"] as num? ?? 0,
      categoryId: json["category_id"] as num? ?? 0,
    );
  }
}
