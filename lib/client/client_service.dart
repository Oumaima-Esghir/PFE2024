import 'dart:convert';

import 'package:dealdiscover/client/client.dart';
import 'package:dealdiscover/client/end_points.dart';
import 'package:dealdiscover/model/partenaire.dart';
import 'package:dealdiscover/model/pub.dart';
import 'package:dealdiscover/model/rates.dart';
import 'package:dealdiscover/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClientService extends Client {
  Future<ClientService> init() async {
    return this;
  }

  Future<List<Pub>> getPubs() async {
    final url = Uri.parse('$baseUrl/pubs'); // Replace with your actual endpoint

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("yes");
      // Decode the response as a list of dynamic objects
      final List<dynamic> data = json.decode(response.body);

      // Map each item in the list to a Pub object
      List<Pub> pubs =
          data.map((pub) => Pub.fromMap(pub as Map<String, dynamic>)).toList();

      return pubs;
    } else {
      throw Exception('Failed to load pubs');
    }
  }

//partners pubs
  Future<List<Pub>> partnerpubs() async {
    final url = Uri.parse('$baseUrl/partenaires/pubs');
    final headers = await getHeaders(); // Obtenir les en-têtes avec le jeton
    print(headers.toString());

    try {
      final response = await http.get(url, headers: headers);
      print("data" + response.body);
      if (response.statusCode == 200) {
        print("API call successful. Decoding response...");

        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData.containsKey('pubs') && responseData['pubs'] is List) {
          final List<dynamic> pubsData = responseData['pubs'];
          print(
              "First pub data: ${pubsData.isNotEmpty ? pubsData[0] : 'No data'}");

          // Mapper chaque élément de la liste vers un objet Pub
          List<Pub> pubs = pubsData.map((pub) {
            // Gestion de la possible absence de certains champs (null safety)
            return Pub.fromMap(pub as Map<String, dynamic>);
          }).toList();

          print("Converted pubs: $pubs");
          return pubs;
        } else {
          print("Error: 'pubs' key not found or is not a list");
          return [];
        }
      } else {
        print('Failed to load pubs, status code: ${response.statusCode}');
        throw Exception('Failed to load pubs');
      }
    } catch (e) {
      print('An error occurred: $e');
      throw Exception('Failed to load pubs due to an error');
    }
  }

  /*Future<http.Response> register(User user) {
    return post(EndPoints.register, body: user.toMap());
  }*/

  //UserSignup
  Future<http.Response> signupuser(User user) async {
    final url = Uri.parse('$baseUrl/users/signup'); // Mettez à jour l'endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'username': user.username,
      'lastname': user.lastname,
      'email': user.email,
      'password': user.password,
      'age': user.age,
      'adress': user.adress
    });

    return await http.post(url, headers: headers, body: body);
  }

  //PartnerSignup
  Future<http.Response> partnersignup(Partenaire partenaire) async {
    final url =
        Uri.parse('$baseUrl/partenaires/signup'); // Mettez à jour l'endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'name': partenaire.name,
      'adress': partenaire.adress,
      'email': partenaire.email,
      'password': partenaire.password,
    });

    return await http.post(url, headers: headers, body: body);
  }

//UserSignin
  Future<http.Response> signinuser(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/signin');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'email': email,
      'password': password,
    });

    final response = await http.post(url, headers: headers, body: body);

    return response;
  }

// Ensure the token is correctly retrieved
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

//PartnerSignin
  Future<http.Response> partnersignin(String email, String password) async {
    final url = Uri.parse('$baseUrl/partenaires/signin');

    print('URL: $url');

    final headers = {'Content-Type': 'application/json'};

    print('Headers: $headers');

    final body = json.encode({
      'email': email,
      'password': password,
    });

    print('Body: $body');

    final response = await http.post(url, headers: headers, body: body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  //addFavorites
  Future<http.Response> addFavourite(String placeId) async {
    final url = Uri.parse('$baseUrl/users/favourites/add/$placeId');

    final headers = await getHeaders(); // Get headers with token
    print(headers.toString());

    return await http.post(
      url,
      headers: headers,
    );
  }

  Future<List<String>> getFavorites() async {
    final url = Uri.parse('$baseUrl/users/favourites');
    // Replace with your actual endpoint

    final headers = await getHeaders(); // Get headers with token
    print(headers.toString());

    final response = await http.get(url, headers: headers);
    print("helllllllllllllllllllllllllo");
    if (response.statusCode == 200) {
      print("helllllllllllllllllllllllllo");
      print(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final favouritePlacesJson = data['data'] as List<dynamic>;
      return favouritePlacesJson.cast<String>();
    } else {
      throw Exception('Failed to load favourite places');
    }
  }

  Future<http.Response> removeFavorite(String placeId) async {
    final url = Uri.parse('$baseUrl/users/favourites/remove/$placeId');

    final headers = await getHeaders(); // Get headers with token
    print(headers.toString());

    return await http.delete(
      url,
      headers: headers,
    );
  }

  Future<http.Response> createRate(int rate, String placeId) async {
    final url = Uri.parse('$baseUrl/rates/$placeId');
    final headers = await getHeaders();
    final body = json.encode({
      // 'id': rate.id.toString(),
      'rate': rate,
      // 'user_id': rate.user_id.toString(),
      // 'rated_id': placeId, // Corrected to use widget.place.id
      // 'review': rate.review,
      // 'rated_name': rate.rated_name, // Assuming this is the correct field
    });

    return await http.post(url, headers: headers, body: body);
  }

  Future<int> getRates(String placeId) async {
    final url = Uri.parse('$baseUrl/rates/$placeId');
    final headers = await getHeaders();
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print("rateeee");
      final data = json.decode(response.body) as Map<String, dynamic>;
      final favouritePlacesJson = data['data'] as List<dynamic>;
      print(favouritePlacesJson[0]['rate']);
      return favouritePlacesJson[0]['rate'];
    } else {
      throw Exception('Failed to load rates');
    }
  }
}
 
  /*
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
  Future<http.Response> createRate(Rate rate, String placeId) async {
    final url = Uri.parse('$baseUrl/rates');
    final headers = await getHeaders();
    final body = json.encode({
      'id': rate.id.toString(),
      'rate': rate.rate,
      'user_id': rate.user_id.toString(),
      'rated_id': placeId, // Corrected to use widget.place.id
      'review': rate.review,
      'rated_name': rate.rated_name, // Assuming this is the correct field
    });

    return await http.post(url, headers: headers, body: body);
  }
  /*
 //getrates
  Future<List<Rate>> getRates() async {
     final url = Uri.parse('$baseUrl${EndPoints.getRates(placeId)}');
  final headers = await getHeaders();
  final response = await http.get(url, headers: headers);

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
  final headers = await getHeaders();
  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    try {
      final responseBody = response.body;
      print('Response body: $responseBody'); // Log the response body for debugging

      final Map<String, dynamic> data = json.decode(responseBody);

      if (data.containsKey('data')) {
        final List<dynamic> ratesList = data['data'];
        return ratesList.map((rateJson) => Rate.fromJson(rateJson)).toList();
      } else {
        throw Exception('Response does not contain expected key "data"');
      }
    } catch (e) {
      throw Exception('Failed to decode response body: $e');
    }
  } else {
    throw Exception('Failed to load rates with status code ${response.statusCode}');
  }
}

  //getFavorites
  Future<List<String>> getFavorites() async {
    final url = Uri.parse(
        '$baseUrl${EndPoints.getfavorites}'); // Replace with your actual endpoint

    final headers = await getHeaders(); // Get headers with token
    print(headers.toString());

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final favouritePlacesJson = data['favouritePlaces'] as List<dynamic>;
      return favouritePlacesJson.cast<String>();
    } else {
      throw Exception('Failed to load favourite places');
    }
  }

//remove Favorites
  Future<http.Response> removeFavorite(String placeId) async {
    final url = Uri.parse('$baseUrl${EndPoints.removefavorites}');

    final headers = await getHeaders(); // Get headers with token
    print(headers.toString());

    final body = json.encode({'placeId': placeId});
    return await http.patch(url, headers: headers, body: body);
  }*/

  //addFavorites
  // Future<http.Response> addFavourite(String placeId) async {
  //   final url = Uri.parse(`$baseUrl/users/favourites/add/`);
  //    Uri.parse('$baseUrl/partenaires/signin');
  //   final headers = await getHeaders(); // Get headers with token
  //   print(headers.toString());
  //   final body = json.encode({
  //     'placeId': placeId,
  //   });

  //   return await http.patch(url, headers: headers, body: body);
  // }



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
