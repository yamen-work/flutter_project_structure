import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../errors/error_handler.dart';

class RemoteApiService {

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://yamen146.pythonanywhere.com",
      connectTimeout:  Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30)
    )
  );


  Future<Response> getRequest(String endpoint) async {
    try
    {
     Response response = await _dio.get(endpoint);

     return response;
    }
    on DioError catch (e)
    {
      debugPrint("GET Error : ${e.message}");
      throw ErrorHandler.handle(e);
    }
  }


  Future<Response> postRequest(String endpoint, Map<String,dynamic> body ) async {
    try
    {
      Response response = await _dio.post(endpoint, data: body);

      return response;
    }
    on DioError catch (e)
    {
      debugPrint("POST Error : ${e.message}");
      throw ErrorHandler.handle(e);

    }
  }


  Future<Response> putRequest(String endpoint, Map<String,dynamic> body ) async {
    try
    {
      Response response = await _dio.put(endpoint, data: body);

      return response;
    }
    on DioError catch (e)
    {
      debugPrint("PUT Error : ${e.message}");
      throw ErrorHandler.handle(e);
    }
  }


  Future<Response> deleteRequest(String endpoint ,String id) async {
    try
    {
      Response response = await _dio.delete("$endpoint/$id/");

      return response;
    }
    on DioError catch (e)
    {
      debugPrint("PUT Error : ${e.message}");
      throw ErrorHandler.handle(e);

      rethrow;
    }
  }





  Future<Response> postFormData(String endpoint,Map<String, dynamic> body,) async {

      try {

        FormData formData = FormData.fromMap(body);

        Response response = await _dio.post(endpoint, data: formData);

        return response;
      } on DioException catch (e) {

        debugPrint("POST FORM DATA Error: ${e.message}");
        throw ErrorHandler.handle(e);

      }
    }

  Future<Response> putFormData(String endpoint,Map<String, dynamic> body,) async {

    try {

      FormData formData = FormData.fromMap(body);

      Response response = await _dio.put(endpoint, data: formData);

      return response;
    } on DioError catch (e) {

      debugPrint("POST FORM DATA Error: ${e.message}");
      throw ErrorHandler.handle(e);

    }
  }


}