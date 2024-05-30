// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:dealdiscover/model/user.dart';

class Rate {
  final String id;
  final double? rate;
  final String userId;
  final String ratedId;
  final int topCount;
  final String review;
  final String userName;

  Rate({
    required this.id,
    required this.rate,
    required this.userId,
    required this.ratedId,
    required this.topCount,
    required this.review,
    required this.userName,
  });

  Rate copyWith({
    String? id,
    double? rate,
    String? userId,
    String? ratedId,
    int? topCount,
    String? review,
    String? userName,
  }) {
    return Rate(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      userId: userId ?? this.userId,
      ratedId: ratedId ?? this.ratedId,
      topCount: topCount ?? this.topCount,
      review: review ?? this.review,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rate': rate,
      'userId': userId,
      'ratedId': ratedId,
      'topCount': topCount,
      'review': review,
      'userName': userName,
    };
  }

  factory Rate.fromMap(Map<String, dynamic> map) {
    return Rate(
      id: map['id'] as String,
      rate: map['rate'] != null ? map['rate'] as double : null,
      userId: map['userId'] as String,
      ratedId: map['ratedId'] as String,
      topCount: map['topCount'] as int,
      review: map['review'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Rate.fromJson(String source) => Rate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rate(id: $id, rate: $rate, userId: $userId, ratedId: $ratedId, topCount: $topCount, review: $review, userName: $userName)';
  }

  @override
  bool operator ==(covariant Rate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.rate == rate &&
      other.userId == userId &&
      other.ratedId == ratedId &&
      other.topCount == topCount &&
      other.review == review &&
      other.userName == userName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      rate.hashCode ^
      userId.hashCode ^
      ratedId.hashCode ^
      topCount.hashCode ^
      review.hashCode ^
      userName.hashCode;
  }
}
