import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = "";
    timeout = const Duration(seconds: 30);
    token = "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(
    String uri,
  ) async {
    try {
      Response response = await get(appBaseUrl + uri, headers: {"Cookie": AppConstants.COOKIE});

      return response;
    } catch (e) {
      if (kDebugMode) {
        print("error api_client");
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getDataWithoutBaseUrl(
    String uri,
  ) async {
    String url = uri;

    try {
      Response response = await get(url, headers: {"Cookie": AppConstants.COOKIE});

      return response;
    } catch (e) {
      if (kDebugMode) {
        print("error $e");
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    var url = AppConstants.BASE_URL + uri;

    try {
      Response response = await post(url, body, headers: _mainHeaders); // si le type de post est future et que le type a droit ne l'est pas on ajoute await

      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postDataAuthenticated(String uri, dynamic body) async {
    try {
      Response response = await get(appBaseUrl + uri,
          headers: {"Cookie": AppConstants.COOKIE}); // si le type de post est future et que le type a droit ne l'est pas on ajoute await

      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }
}
