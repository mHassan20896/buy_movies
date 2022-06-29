import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart';

import 'logs_interceptors.dart';
import 'url.dart' as url;

class HttpService {
  const HttpService({required this.client});

  final Client client;
  final String baseUrl = url.baseUrl;
  final LogsInterceptor logsInterceptor = const LogsInterceptor();

  Future<Either<Map<String, dynamic>, List>> get({
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required String path,
  }) async {
    logsInterceptor.onRequest(path, 'GET',
        queryParameters: queryParams, headers: headers);

    final rawResponse = await client.get(
      Uri.https(baseUrl, path, queryParams),
      headers: headers,
    );

    final response = jsonDecode(rawResponse.body);

    logsInterceptor.onResponse(path, 'GET',
        body: response, statusCode: rawResponse.statusCode);

    return _handleJsonSerialization(response);
  }

// Triple<Map, List, String>

  Future<Either<Map<String, dynamic>, List>> post({
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    required String path,
  }) async {
    logsInterceptor.onRequest(path, 'POST',
        queryParameters: queryParams, headers: headers, body: body);

    final rawResponse = await client.post(
      Uri.https(baseUrl, path, queryParams),
      body: jsonEncode(body),
    );

    final response = jsonDecode(rawResponse.body);

    logsInterceptor.onResponse(path, 'POST',
        body: response, statusCode: rawResponse.statusCode);

    return _handleJsonSerialization(response);
  }

  Either<Map<String, dynamic>, List> _handleJsonSerialization(
      dynamic response) {
    if (response is! List) {
      final decodedObject = response as Map<String, dynamic>;
      return Left(decodedObject);
    } else {
      return Right(response);
    }
  }
}
