// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:dealdiscover/model/user.dart';

class Rate {
  final String id;
  final int rate;
  final String user_id;
  final String rated_id;
  final String review;
  final String rated_name;

  Rate({
    required this.id,
    required this.rate,
    required this.user_id,
    required this.rated_id,
    required this.review,
    required this.rated_name,
  });

  Rate copyWith({
    String? id,
    int? rate,
    String? user_id,
    String? rated_id,
    String? review,
    String? rated_name,
  }) {
    return Rate(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      user_id: user_id ?? this.user_id,
      rated_id: rated_id ?? this.rated_id,
      review: review ?? this.review,
      rated_name: rated_name ?? this.rated_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'user_id': user_id,
      'rated_id': rated_id,
      'review': review,
      'rated_name': rated_name,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map['id'] as String,
      rate: map['rate'] as int,
      user_id: map['user_id'] as String,
      rated_id: map['rated_id'] as String,
      review: map['review'] as String,
      rated_name: map['rated_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source) as Map<String, dynamic>);
  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      id: json['id'] as String,
      rate: json['rate'] as int,
      user_id: json['user_id'] as String,
      rated_id: json['rated_id'] as String,
      rated_name: json['rated_name'] as String,
      review: json['review'] as String,
    );
  }

  @override
  String toString() {
    return 'Rate(id: $id, rate: $rate, user_id: $user_id, rated_id: $rated_id, review: $review, rated_name: $rated_name)';
  }

  @override
  bool operator ==(covariant Rate other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rate == rate &&
        other.user_id == user_id &&
        other.rated_id == rated_id &&
        other.review == review &&
        other.rated_name == rated_name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rate.hashCode ^
        user_id.hashCode ^
        rated_id.hashCode ^
        review.hashCode ^
        rated_name.hashCode;
  }
}
