import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../source/local.dart';

class ApiHelper {
  static const String baseUrl =
      "https://apex-biotics-supplement-be.vercel.app/api";
  static Future<Map<String, String>> getHeaders() async {
    var token = await LocalStorage.getString(LocalStorage.tokenKey);
    log(token.toString());
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  static Future<dynamic> get(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    log("GET Request => $url");
    final headers = await getHeaders();

    var header = getHeaders();
    final response = await http.get(url, headers: headers);
    // log("Response (${response.statusCode}): ${response.body}");
    return _handleResponse(response);
  }

  static Future<dynamic> post(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    log("POST Request => $url\nBody: $body");
    final headers = await getHeaders();

    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));
    return _handleResponse(response);
  }

  static Future<ApiResponse<dynamic>> postFile(
    String endpoint, {
    required String name,
    required File imageFile,
    required String fileFieldKey, // e.g., 'profilePicture'
    String method = 'PUT',
  }) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final headers = await getHeaders();

    log("🌐 $method FILE Request => $url");
    log("📤 Name => $name");
    log("🖼️ File => ${imageFile.path}");

    final request = http.MultipartRequest(method, url);
    request.headers.addAll(headers);

    // Add 'name' field
    request.fields['name'] = name;

    // Add file
    final mimeType = lookupMimeType(imageFile.path)?.split('/');
    final multipartFile = await http.MultipartFile.fromPath(
      fileFieldKey,
      imageFile.path,
      contentType: mimeType != null
          ? MediaType(mimeType[0], mimeType[1])
          : MediaType('application', 'octet-stream'),
    );
    request.files.add(multipartFile);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    log("📥 Upload Response [${response.statusCode}]: ${response.body}");

    return _handleResponse(response);
  }

  static Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    log("PUT Request => $url\nBody: $body");
    final headers = await getHeaders();

    final response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    log("Response (${response.statusCode}): ${response.body}");
    return _handleResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    log("DELETE Request => $url");
    final headers = await getHeaders();

    final response = await http.delete(url, headers: headers);
    log("Response (${response.statusCode}): ${response.body}");
    return _handleResponse(response);
  }

  static ApiResponse<T> _handleResponse<T>(http.Response response) {
    log("RESPONSE [${response.statusCode}]: ${response.body}");
    switch (response.statusCode) {
      case 200:
      case 201:
        final decoded = jsonDecode(response.body);
        return ApiResponse<T>(
          success: true,
          data: decoded,
        );
      case 400:
        return ApiResponse<T>(success: false, message: "Bad Request");
      case 401:
        return ApiResponse<T>(success: false, message: "Unauthorized");
      case 403:
        return ApiResponse<T>(success: false, message: "Forbidden");
      case 404:
        return ApiResponse<T>(success: false, message: "Not Found");
      case 500:
        return ApiResponse<T>(success: false, message: "Internal Server Error");
      default:
        return ApiResponse<T>(success: false, message: "Unknown Error");
    }
  }
}

class ApiResponse<T> {
  final bool success;
  final String? message;
  final T? data;

  ApiResponse({
    required this.success,
    this.message,
    this.data,
  });
}
