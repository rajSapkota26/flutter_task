import 'dart:convert';
import 'package:http/http.dart' as http;

import '../custom_exception/http_response_exception.dart';

class CustomHttpHelper {
  static const String _baseUrl = 'https:/'; // Replace with  API base URL
  static final CustomHttpHelper _instance = CustomHttpHelper._internal();
  static const Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  // Private constructor
  CustomHttpHelper._internal();

  // Factory constructor to return the singleton instance
  factory CustomHttpHelper() {
    return _instance;
  }

  // Helper method to make a GET request
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  // Helper method to make a POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Helper method to make a DELETE request
  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: _headers,
    );
    return _handleResponse(response);
  }

  // Handle the HTTP response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return json.decode(response.body);
    } else if (response.statusCode == 401) {
      throw SessionExpiredException('Session Expired', response.statusCode);
    } else if (response.statusCode == 404) {
      throw CustomException('Page Not Found', response.statusCode);
    } else if ((response.statusCode >= 400 && response.statusCode <= 499)) {
      throw CustomException('Error', response.statusCode);
    } else if ((response.statusCode >= 500 && response.statusCode <= 599)) {
      throw CustomException('Server Error', response.statusCode);
    } else {
      throw CustomException('Failed to load data', response.statusCode);
    }
  }
}
