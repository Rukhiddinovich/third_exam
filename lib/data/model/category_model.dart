class CategoryModel {
  final num id;
  final String name;
  final String imageUrl;
  final String createdAt;

  CategoryModel(
      {required this.name,
      required this.id,
      required this.createdAt,
      required this.imageUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"] as String? ?? "",
      id: json["id"] as num? ?? 0,
      createdAt: json["created_at"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
    );
  }
}
