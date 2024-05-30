// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Place {
  String id;
  final double? rate;
  String name;
  String location;
  String description;
  final List<String> placeImage;
  String type;

  Place({
    required this.id,
    required this.rate,
    required this.name,
    required this.location,
    required this.description,
    required this.placeImage,
    required this.type,
  });

  Place copyWith({
    String? id,
    double? rate,
    String? name,
    String? location,
    String? description,
    List<String>? placeImage,
    String? type,
  }) {
    return Place(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      placeImage: placeImage ?? this.placeImage,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'name': name,
      'location': location,
      'description': description,
      'placeImage': placeImage,
      'type': type,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] as String,
      rate: map['rate'] != null ? map['rate'] as double : null,
      name: map['name'] as String,
      location: map['location'] as String,
      description: map['description'] as String,
      placeImage: List<String>.from(map['placeImage'] as List),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(id: $id, rate: $rate, name: $name, location: $location, description: $description, placeImage: $placeImage, type: $type)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rate == rate &&
        other.name == name &&
        other.location == location &&
        other.description == description &&
        listEquals(other.placeImage, placeImage) &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rate.hashCode ^
        name.hashCode ^
        location.hashCode ^
        description.hashCode ^
        placeImage.hashCode ^
        type.hashCode;
  }
}
