import 'package:borgiaflutterapp/utils/app_constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = "";
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
    //print(url);
    try {
      Response response = await get(appBaseUrl + uri);

      //print(response.body);

      return response;
    } catch (e) {
      print("error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> getDataWithoutBaseUrl(
    String uri,
  ) async {
    String url = uri;
    //print("the url" + url);
    try {
      Response response = await get(url);
      //print(response.body);

      return response;
    } catch (e) {
      print("error" + e.toString());
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body) async {
    print(body.toString());
    var url = AppConstants.BASE_URL + uri;

    try {
      Response response = await post(url, body, headers: _mainHeaders); // si le type de post est future et que le type a droit ne l'est pas on ajoute await

      print(response.toString());

      return response;
    } catch (e) {
      print(e.toString());
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
