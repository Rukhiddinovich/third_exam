import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:third_exam_n8/data/universal_response.dart';

UniversalResponse handleHttpErrors(http.Response response) {
  switch (response.statusCode) {
    case HttpStatus.badRequest:
      {
        return UniversalResponse(
          error: "Bad request exception",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.unauthorized:
      {
        return UniversalResponse(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.forbidden:
      {
        return UniversalResponse(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notFound:
      {
        return UniversalResponse(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.tooManyRequests:
      {
        return UniversalResponse(
          error: jsonDecode(response.body)["message"],
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.internalServerError:
      {
        return UniversalResponse(
          error:
          "Error occurred while Communication with Server with StatusCode : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    case HttpStatus.notImplemented:
      {
        return UniversalResponse(
          error: "Server Error : ${response.statusCode}",
          statusCode: response.statusCode,
        );
      }
    default:
      return UniversalResponse(
        error: "Unknown Error occurred!",
        statusCode: response.statusCode,
      );
  }
}