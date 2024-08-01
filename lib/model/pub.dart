// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pub {
  String id;
  final int? rating;
  String? title;
  String? address;
  String? description;
  final String? pubImage;
  String? category;
  final int? nb_likes;
  final String? state;
  String? duree;
  final int? pourcentage;

  Pub({
    required this.id,
    required this.rating,
    required this.title,
    required this.address,
    required this.description,
    required this.pubImage,
    required this.category,
    required this.nb_likes,
    required this.state,
    required this.duree,
    required this.pourcentage,
  });

  Pub copyWith({
    String? id,
    int? rating,
    String? title,
    String? address,
    String? description,
    String? pubImage,
    String? category,
    int? nb_likes,
    String? state,
    String? duree,
    int? pourcentage,
  }) {
    return Pub(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      address: address ?? this.address,
      description: description ?? this.description,
      pubImage: pubImage ?? this.pubImage,
      category: category ?? this.category,
      nb_likes: nb_likes ?? this.nb_likes,
      state: state ?? this.state,
      duree: duree ?? this.duree,
      pourcentage: pourcentage ?? this.pourcentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rating': rating,
      'title': title,
      'address': address,
      'description': description,
      'pubImage': pubImage,
      'category': category,
      'nb_likes': nb_likes,
      'state': state,
      'duree': duree,
      'pourcentage': pourcentage,
    };
  }

  factory Pub.fromMap(Map<String, dynamic> map) {
    return Pub(
      id: map['_id'] as String,
      rating: map['rating'] != null ? map['rating'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      pubImage: map['pubImage'] as String,
      category: map['category'] != null ? map['category'] as String : null,
      nb_likes: map['nb_likes'] != null ? map['nb_likes'] as int : null,
      state: map['state'] != null ? map['state'] as String : null,
      duree: map['duree'] != null ? map['duree'] as String : null,
      pourcentage:
          map['pourcentage'] != null ? map['pourcentage'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pub.fromJson(String source) =>
      Pub.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pub(id: $id, rating: $rating, title: $title, address: $address, description: $description, pubImage: $pubImage, category: $category, nb_likes: $nb_likes, state: $state, duree: $duree, pourcentage: $pourcentage)';
  }

  @override
  bool operator ==(covariant Pub other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rating == rating &&
        other.title == title &&
        other.address == address &&
        other.description == description &&
        other.pubImage == pubImage &&
        other.category == category &&
        other.nb_likes == nb_likes &&
        other.state == state &&
        other.duree == duree &&
        other.pourcentage == pourcentage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rating.hashCode ^
        title.hashCode ^
        address.hashCode ^
        description.hashCode ^
        pubImage.hashCode ^
        category.hashCode ^
        nb_likes.hashCode ^
        state.hashCode ^
        duree.hashCode ^
        pourcentage.hashCode;
  }
}
