import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:frontend/core/network/i_client.dart';

const String errorMessage = "Something went wrong!";

class AppNetworkClient implements IClient {
  late final Map<String, String> headers;
  late final Dio dio;

  AppNetworkClient() {
    headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://curiously-cunning-eft.ngrok-free.app/v1/',
      ),
    );
  }

  @override
  Future<T> getAsync<T>(
    String resourcePath, {
    Map<String, dynamic> queryParams = const {},
  }) async {
    Response<T> response;
    try {
      response = await dio.get<T>(
        resourcePath,
        queryParameters: queryParams,
      );
      
      if (response.statusCode == 200) {
        return response.data!;
      }
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<T> postAsync<T>(
    String resourcePath,
    Map data, {
    Map<String, dynamic> queryParams = const {},
  }) async {
    final content = jsonEncode(data);
    Response<T> response;
    try {
      response = await dio.post<T>(
        resourcePath,
        data: content,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return response.data!;
      }

      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
