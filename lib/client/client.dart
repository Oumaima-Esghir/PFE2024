import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'end_points.dart';

class Client {
  final String serverUrl = "http://192.168.1.6:3000";
   final String baseUrl = "http://192.168.1.6:3000";//allaghaleb si ala

  // final String serverUrl = "http://10.0.2.2:3000";
  // final String baseUrl = "http://10.0.2.2:3000";

  Map<String, String> appHeaders = {
    'Content-Type': "application/json",
    'Accept': "application/json",
    'accept-language': Platform.localeName.split('_')[0]
  };

  String fullUrl(path) {
    return baseUrl + path;
  }

  Future<http.Response> getPath(String path, {Map<String, String>? headers}) {
    Map<String, String> mheaders = {};
    mheaders.addAll(appHeaders);
    mheaders.addAll(headers ?? {});

    Uri uri = Uri.parse(fullUrl(path));
    return responseBuilder(http.get(
      uri,
      headers: mheaders,
    ));
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? "";
  }

  setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  disconnect() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<http.Response> get(String path,
      {Map<String, String>? headers,
      Map<String, String>? params,
      bool useToken = true}) async {
    Map<String, String> mheaders = {};
    mheaders.addAll(appHeaders);
    mheaders.addAll(headers ?? {});

    if (useToken) {
      final token = await getToken();
      mheaders.addAll({'Authorization': "Bearer $token"});
    }
    String url = fullUrl(path);
    String queryString = Uri(queryParameters: params).query;

    var requestUrl = url + '?' + queryString;
    Uri uri = Uri.parse(requestUrl);
    return responseBuilder(http.get(
      uri,
      headers: mheaders,
    ));
  }

  Future<http.Response> post(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      bool useToken = true,
      bool isQuery = false}) async {
    Map<String, String> mheaders = {};
    mheaders.addAll(appHeaders);
    mheaders.addAll(headers ?? {});

    print("body" + body.toString());
    if (useToken) {
      final token = await getToken();
      mheaders.addAll({'Authorization': "Bearer $token"});
    }
    if (isQuery) {
      String url = fullUrl(path).replaceAll("https://", "");
      String subUrl = url;
      List<String> urls = url.split('/');
      String domain = urls[0];
      if (urls.length > 1) {
        subUrl = url.substring(url.indexOf('api'));
      }
      Uri uri = Uri.https(domain, subUrl, body);
      return responseBuilder(http.post(
        uri,
        headers: mheaders,
      ));
    } else {
      String url = fullUrl(path);
      Uri uri = Uri.parse(url);
      return responseBuilder(http.post(
        uri,
        headers: mheaders,
        body: json.encode(body ?? {}),
      ));
    }
  }

  Future<http.Response> put(String path,
      {Map<String, String>? headers, Map<String, dynamic>? body}) {
    Map<String, String> mheaders = {};
    mheaders.addAll(appHeaders);
    mheaders.addAll(headers ?? {});
    String url = fullUrl(path);
    Uri uri = Uri.parse(url);
    return responseBuilder(http.put(
      uri,
      headers: mheaders,
      body: json.encode(body ?? {}),
    ));
  }

  Future<http.Response> delete(String path,
      {Map<String, String>? headers,
      Map<String, dynamic>? body,
      bool useToken = true,
      bool isQuery = false}) async {
    Map<String, String> mheaders = {};
    if (useToken) {
      final token = await getToken();
      mheaders.addAll({'Authorization': "Bearer $token"});
    }
    mheaders.addAll(appHeaders);
    mheaders.addAll(headers ?? {});
    if (isQuery) {
      String url = fullUrl(path).replaceAll("https://", "");
      String subUrl = url;
      List<String> urls = url.split('/');
      String domain = urls[0];
      if (urls.length > 1) {
        subUrl = url.substring(url.indexOf('api'));
      }
      Uri uri = Uri.https(domain, subUrl, body ?? {});
      return responseBuilder(http.delete(uri, headers: mheaders));
    } else {
      String url = fullUrl(path);
      Uri uri = Uri.parse(url);
      return responseBuilder(
          http.delete(uri, headers: mheaders, body: json.encode(body ?? {})));
    }
  }

  Future<http.Response> multiPart(String path,
      {String action = "PUT",
      Map<String, String>? headers,
      Map<String, dynamic>? body,
      bool multipart = true,
      Map<String, File> namedFiles = const {},
      List<File> files = const []}) async {
    String url = fullUrl(path);
    Uri uri = Uri.parse(url);

    var request = http.MultipartRequest(action, uri);

    request.headers.addAll(headers ?? {});

    if (multipart) {
      request.headers[HttpHeaders.contentTypeHeader] =
          'multipart/form-data;charset=utf-8;application/json';

      request.headers['accept-language'] = Platform.localeName.split('_')[0];
    }
    print("iiiii" + request.headers.toString());

    body?.forEach((key, value) {
      if (value != null) request.fields[key] = value.toString();
    });

    for (var file in files) {
      final image = await http.MultipartFile.fromPath("image", file.path);
      request.files.add(image);
    }

    namedFiles.forEach((key, mfile) async {
      final file = await http.MultipartFile.fromPath(key, mfile.path);
      request.files.add(file);
    });
    print("iiiii" + request.fields.toString());

    return request.send().then((http.StreamedResponse value) {
      return value.stream
          .bytesToString()
          .then((body) => Future.value(http.Response(body, value.statusCode)))
          .catchError((d) => Future.value(http.Response('', 500)));
    });
  }

  Future<http.Response> responseBuilder(Future<http.Response> baseResponse) {
    return baseResponse.onError((error, stackTrace) {
      return Future.value(http.Response("{}", 404));
    }).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        return http.Response('Time out', 408);
      },
    );
  }
}
