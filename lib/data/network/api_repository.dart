import 'package:third_exam_n8/data/network/api_provider.dart';

import '../model/category_model.dart';
import '../model/product_model.dart';
import '../universal_response.dart';


class ApiRepository{
  final ApiProvider apiProvider;
  ApiRepository({required this.apiProvider});

  Future<List<ProductModel>> fetchAllProducts()async{
    UniversalResponse universalResponse=await apiProvider.getAllProducts();
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  List<ProductModel>;
    }
    return [];
  }

  Future<List<ProductModel>> fetchProductsByCategory({required String id})async{
    UniversalResponse universalResponse=await apiProvider.getProductsByCategoryId(id: id);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  List<ProductModel>;
    }
    return [];
  }

  Future<List<CategoryModel>> fetchAllCategories()async{
    UniversalResponse universalResponse=await apiProvider.getAllCategories();
    if(universalResponse.error.isEmpty){
      return universalResponse.data as  List<CategoryModel>;
    }
    return [];
  }
}