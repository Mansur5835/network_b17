import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  static bool isTester = true;

  static const String SERVER_DEVELOPMENT =
      "62a72d2697b6156bff895bcb.mockapi.io";
  static const String SERVER_PRODUCTION = "62a72d2697b6156bff895bcb.mockapi.io";
  static const String API_USER = "/user";
  static const String API_USER_CREATE = "/user";
  static const String API_USER_DELETE = "/user/"; //ID
  static const String API_USER_UPDATE = "/user/"; //ID

  static String getServer() {
    if (isTester) {
      return SERVER_DEVELOPMENT;
    }
    return SERVER_PRODUCTION;
  }

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.http(getServer(), api, params);
    http.Response? response = await http.get(uri);
    print(response.statusCode);

    if (response.statusCode != 200) {
      return null;
    }

    return response.body;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.http(getServer(), api);
    http.Response? response = await http.post(uri, body: params);
    print(response.body);

    if (response.statusCode != 200 || response.statusCode != 201) {
      return null;
    }

    return response.body;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.https(getServer(), api);
    http.Response? response = await http.delete(uri, body: params);
    print(response.statusCode);

    if (response.statusCode != 200 || response.statusCode != 201) {
      return null;
    }

    return response.body;
  }

  static Future<String?> UPDATE(String api, Map<String, dynamic> params) async {
    Uri uri = Uri.http(getServer(), api);
    http.Response? response = await http.put(uri, body: jsonEncode(params));
    print(response.body);

    return response.body;
  }
}
