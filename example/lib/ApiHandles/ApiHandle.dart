import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHandler {

  static setHeadersPost(String accessToken){
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': accessToken
    };
  }

  static Future<dynamic> loginPost(body, url) async {
    setHeadersPost() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.post(
        baseUrl, headers: setHeadersPost(), body: jsonEncode(body)
    );

    return response;
  }

  static Future<dynamic> get(url,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.get(
        baseUrl, headers: setHeadersPost(accessToken)
    );

    return response;
  }

  static Future<dynamic> delete(url,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.delete(
        baseUrl, headers: setHeadersPost(accessToken)
    );

    return response;
  }

  static Future<dynamic> put(body, url,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.put(
        baseUrl, headers: setHeadersPost(accessToken), body: jsonEncode(body)
    );

    return response;
  }

  static Future<dynamic> post(body, url,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.post(
        baseUrl, headers: setHeadersPost(accessToken), body: jsonEncode(body)
    );

    return response;
  }

  static Future<dynamic> postWithoutBody(url,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.post(
      baseUrl, headers: setHeadersPost(accessToken),
    );

    return response;
  }

  static Future<dynamic> deleteBody(url,body,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url');
    http.Response response = await http.delete(
        baseUrl, body: jsonEncode(body), headers: setHeadersPost(accessToken)
    );

    return response;
  }

  static Future<dynamic>  getParams(url, params,accessToken) async {

    var baseUrl = Uri.http("137.184.233.122", '/api/v1/$url',params);
    http.Response response = await http.get(
        baseUrl, headers: setHeadersPost(accessToken)
    );

    return response;
  }

}
