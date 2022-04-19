import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(
    String uri,
  ) async {
    String url = baseUrl! + uri;
    print(url);
    try {
      Response response = await get(uri);

      //print(response.body);

      return response;
    } catch (e) {
      print("error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
