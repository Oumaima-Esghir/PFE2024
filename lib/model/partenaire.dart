import 'dart:convert';
import 'package:dealdiscover/model/pub.dart';
import 'package:flutter/foundation.dart';

class Partenaire {
  int? partenaire_id;
  String name;
  String image;
  String email;
  String password;
  String adress;
  // final List<Pub> publications;

  Partenaire({
    required this.partenaire_id,
    required this.name,
    required this.image,
    required this.email,
    required this.password,
    required this.adress,
    // required this.publications,
  });

  Partenaire copyWith({
    int? partenaire_id,
    String? name,
    String? image,
    String? email,
    String? password,
    String? adress,
    List<Pub>? publications,
  }) {
    return Partenaire(
      partenaire_id: partenaire_id ?? this.partenaire_id,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      password: password ?? this.password,
      adress: adress ?? this.adress,
      // publications: publications ?? this.publications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'partenaire_id': partenaire_id,
      'name': name,
      'image': image,
      'email': email,
      'password': password,
      'adress': adress,
      // 'publications': publications.map((x) => x.toMap()).toList(),
    };
  }

  factory Partenaire.fromMap(Map<String, dynamic> map) {
    return Partenaire(
      partenaire_id:
          map['partenaire_id'] != null ? map['partenaire_id'] as int : null,
      name: map['name'] as String,
      image: map['image'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      adress: map['adress'] as String,
      // publications: List<Pub>.from((map['publications'] as List)
      // .map<Pub>((x) => Pub.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Partenaire.fromJson(String source) =>
      Partenaire.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Partenaire(partenaire_id: $partenaire_id, name: $name, image: $image, email: $email, password: $password, adress: $adress,)';
  }

  @override
  bool operator ==(covariant Partenaire other) {
    if (identical(this, other)) return true;

    return other.partenaire_id == partenaire_id &&
        other.name == name &&
        other.image == image &&
        other.email == email &&
        other.password == password &&
        other.adress == adress;
    // listEquals(other.publications, publications);
  }

  @override
  int get hashCode {
    return partenaire_id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        email.hashCode ^
        password.hashCode ^
        adress.hashCode;
    // publications.hashCode;
  }
}
