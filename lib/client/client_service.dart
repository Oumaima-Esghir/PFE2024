import 'dart:convert';

import 'package:dealdiscover/client/client.dart';
import 'package:dealdiscover/client/end_points.dart';
import 'package:dealdiscover/model/place.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:http/http.dart' as http;

class ClientService extends Client {
  Future<ClientService> init() async {
    return this;
  }

  /*Future<http.Response> register(User user) {
    return post(EndPoints.register, body: user.toMap());
  }*/

  //register
  Future<http.Response> register(User user) async {
    final url = Uri.parse('$baseUrl/register'); // Mettez à jour l'endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      //'name': user.name,
      'email': user.email,
      'password': user.password,
      'role': user.role,
      'username': user.username,
    });

    return await http.post(url, headers: headers, body: body);
  }

//login
  Future<http.Response> login(String email, String password) async {
    final url =
        Uri.parse('$baseUrl/login'); // Update with your actual login endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': email,
      'password': password,
    });

    return await http.post(url, headers: headers, body: body);
  }

//getplaces
  /*Future<List<Place>> getPlaces() async {
    final url = Uri.parse('$baseUrl/place/page'); // Replace with your actual endpoint

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((place) => Place.fromMap(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }*/

  //getplaces
  Future<List<Place>> getPlaces() async {
    final url =
        Uri.parse('$baseUrl/place/page'); // Replace with your actual endpoint

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final placesJson = data['data'] as List;
      return placesJson.map((place) => Place.fromMap(place)).toList();
    } else {
      throw Exception('Failed to load places');
    }
  }

//createrate
  Future<http.Response> createRate(Rate rate) async {
    final url = Uri.parse('$baseUrl/rates');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'id': rate.id.toString(),
      'rate': rate.rate,
      'userId': rate.userId.toString(),
      'ratedId': rate.ratedId,
      'topCount': rate.topCount,
      'review': rate.review,
      'userName': rate.userName,
    });

    return await http.post(url, headers: headers, body: body);
  }

  /*
 //getrates
  Future<List<Rate>> getRates() async {
    final url = Uri.parse('$baseUrl/rates/page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((rateJson) => Rate.fromJson(rateJson)).toList();
    } else {
      throw Exception('Failed to load rates');
    }
  }*/
//getrates
  Future<List<Rate>> getRates(String placeId) async {
    final url = Uri.parse('$baseUrl${EndPoints.getRates(placeId)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((rateJson) => Rate.fromJson(rateJson)).toList();
    } else {
      throw Exception('Failed to load rates');
    }
  }
  /*Future<http.Response> login(Login login) {
    
    return post(EndPoints.login, body: login.toMap(), useToken: false);
  }

  Future<http.Response> me() {
    return get(EndPoints.me);
  }

  Future<http.Response> news(int skip, int take) {
    return get(EndPoints.news, params: {"skip": "$skip", "take": "$take"});
  }

  Future<http.Response> requestForgetPassword(String email) {
    return post(EndPoints.requestForgetPassword, body: {"email": email});
  }

  Future<http.Response> resetPassword(
      String email, String password, String code) {
    return post(EndPoints.resetPassword,
        body: {"email": email, "password": password, "code": code});
  }

  Future<http.Response> getPurchases(int skip, int take, int id) {
    return get(EndPoints.queryPath(EndPoints.getPurchases, [id.toString()]),
        params: {"email": "$skip", "password": "$take"});
  }

  Future<http.Response> addFavorite(int id) {
    return post(
      EndPoints.queryPath(EndPoints.favorite, [id.toString()]),
    );
  }

  Future<http.Response> removeFavorite(int id) {
    return delete(
      EndPoints.queryPath(EndPoints.favorite, [id.toString()]),
    );
  }

  Future<http.Response> participate(int id) {
    return post(
      EndPoints.queryPath(EndPoints.participate, [id.toString()]),
    );
  }

  Future<http.Response> removeParticipation(int id) {
    return delete(
      EndPoints.queryPath(EndPoints.participate, [id.toString()]),
    );
  }

  Future<http.Response> makePurchases(int code) {
    return post(EndPoints.makePurchase, body: {"companyBranchId": code});
  }

  Future<http.Response> home(double lat, double lng) {
    return get(EndPoints.home,
        params: {"take": "6", "latitude": "$lat", "longitude": "$lng"});
  }

  Future<http.Response> companies(
      double lat, double lng, int categoryId, int skip) {
    return get(EndPoints.companies, params: {
      "skip": "$skip",
      "take": "10",
      "categoryId": "$categoryId",
      "latitude": "$lat",
      "longitude": "$lng"
    });
  }

  Future<http.Response> categories() {
    return get(EndPoints.categories);
  }

  Future<http.Response> events(int skip, int take, String name,
      String dateStart, String dateEnd, String type, int organization) {
    return get(EndPoints.events, params: {
      "skip": "$skip",
      "take": "$take",
      "name": name,
      "dateStart": dateStart,
      "dateEnd": dateEnd,
      "type": type,
    });
  }

  Future<http.Response> eventById(int id) {
    return get(
      EndPoints.queryPath(EndPoints.eventDetail, [id.toString()]),
    );
  }*/
}
