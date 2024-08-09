/*
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Pub {
  String id;
  final double? rating;
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
    double? rating,
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
      id: map['id'] as String,
      rating: map['rating'] != null ? map['rating'] as double : null,
      title: map['title'] != null ? map['title'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      pubImage: map['pubImage'] != null ? map['pubImage'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      nb_likes: map['nb_likes'] != null ? map['nb_likes'] as int : null,
      state: map['state'] != null ? map['state'] as String : null,
      duree: map['duree'] != null ? map['duree'] as String : null,
      pourcentage: map['pourcentage'] != null ? map['pourcentage'] as int : null,
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
*/
import 'dart:convert';

class Pub {
  String id;
  final double? rating;
  String? title;
  String? address;
  String? description;
  final String? pubImage;
  String? category;
  final String? state;
  String? duree;
  final int? pourcentage;

  ///
  Pub({
    required this.id,
    required this.rating,
    required this.title,
    required this.address,
    required this.description,
    required this.pubImage,
    required this.category,
    required this.state,
    this.duree,
    this.pourcentage,
  });
}

List<Pub> listOfIPubs = [
  Pub(
    id: "1",
    rating: 6.5,
    title: "Hotel Les Palmiers",
    address: "Monastir",
    description:
        "Hotel les Palmiers is located directly on Skanes beach, a 5-minute drive from Monastir city center. It offers rooms with views of the sea or the outdoor swimming pools and garden. ",
    pubImage: "assets/images/palmier.png",
    category: "hotel",
    state: "promo",
    duree: "3j",
    pourcentage: 20,
  ),
  Pub(
    id: "2",
    rating: 4.3,
    title: "Café Sidi Salem La Grotte",
    address: "Mahdia",
    description: "promo sur la pizza ",
    pubImage: "assets/images/sidisalem.jpg",
    category: "restaurant",
    state: "offre",
    duree: "2j",
    pourcentage: 50,
  ),
  Pub(
    id: "3",
    rating: 5,
    title: "Marina Cap Monastir- Appart'Hôtel",
    address: "hotel",
    description:
        "Located next to the marina and the beach, in a 5 minutes walk from the city center, the apart hotel Marina Cap Monastir is ideal for a relaxing stay.",
    pubImage: "assets/images/marina.png",
    category: "hotel",
    state: "offre",
    //duree: "DealDiscover",
    //pourcentage: 20,
  ),
  Pub(
    id: "4",
    rating: 4.3,
    title: "El Jem Amphitheater",
    address: "ElJem",
    description:
        "This vast, golden-stoned amphitheater, dating from the 2nd century CE, rises to 40 meters high and is the fourth largest in the world, as well as being one of the best preserved surviving examples of amphitheater architecture.",
    pubImage: 'assets/images/jem.jpg',
    category: "monument",
    state: "offre",
    //duree: "DealDiscover",
    //pourcentage: 20,
  ),
];
