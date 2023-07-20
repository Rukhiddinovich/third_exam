import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../utils/constants.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
import '../universal_response.dart';
import 'network_utils.dart';

class ApiProvider {
  Future<UniversalResponse> getAllProducts() async {
    Uri uri = Uri.parse("$baseUrl/products");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body)["data"] as List?)
                    ?.map((e) => ProductModel.fromJson(e))
                    .toList() ??
                []);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR:$err. ERROR TYPE: ${err.runtimeType}");
      return UniversalResponse(error: err.toString());
    }
  }

  Future<UniversalResponse> getProductsByCategoryId(
      {required String id}) async {
    Uri uri = Uri.parse("$baseUrl/categories/$id");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => ProductModel.fromJson(e))
                    .toList() ??
                []);
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR:$err. ERROR TYPE: ${err.runtimeType}");
      return UniversalResponse(error: err.toString());
    }
  }

  Future<UniversalResponse> getAllCategories() async {
    Uri uri = Uri.parse("$baseUrl/categories");
    try {
      http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)
                    ?.map((e) => CategoryModel.fromJson(e))
                    .toList() ??
                [],
        );
      }
      return handleHttpErrors(response);
    } on SocketException {
      return UniversalResponse(error: "Internet Error!");
    } on FormatException {
      return UniversalResponse(error: "Format Error!");
    } catch (err) {
      debugPrint("ERROR:$err. ERROR TYPE: ${err.runtimeType}");
      return UniversalResponse(error: err.toString());
    }
  }
}
