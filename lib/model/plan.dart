// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plan {
  String? id;
  String? userId;
  String? pubId;
  String? title;
  String? dateFrom;
  String? dateTo;
  String? timeFrom;
  String? timeTo;
  int? nb_persons;
  String? reminder;

  Plan({
    this.id,
    this.userId,
    required this.pubId,
    required this.title,
    required this.dateFrom,
    required this.dateTo,
    required this.timeFrom,
    required this.timeTo,
    required this.nb_persons,
    required this.reminder,
  });

  Plan copyWith({
    String? id,
    String? userId,
    String? pubId,
    String? title,
    String? dateFrom,
    String? dateTo,
    String? timeFrom,
    String? timeTo,
    int? nb_persons,
    String? reminder,
  }) {
    return Plan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      pubId: pubId ?? this.pubId,
      title: title ?? this.title,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      timeFrom: timeFrom ?? this.timeFrom,
      timeTo: timeTo ?? this.timeTo,
      nb_persons: nb_persons ?? this.nb_persons,
      reminder: reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'pubId': pubId,
      'title': title,
      'dateFrom': dateFrom,
      'dateTo': dateTo,
      'timeFrom': timeFrom,
      'timeTo': timeTo,
      'nb_persons': nb_persons,
      'reminder': reminder,
    };
  }

  factory Plan.fromMap(Map<String, dynamic> map) {
    return Plan(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      pubId: map['pubId'] != null ? map['pubId'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      dateFrom: map['dateFrom'] != null ? map['dateFrom'] as String : null,
      dateTo: map['dateTo'] != null ? map['dateTo'] as String : null,
      timeFrom: map['timeFrom'] != null ? map['timeFrom'] as String : null,
      timeTo: map['timeTo'] != null ? map['timeTo'] as String : null,
      nb_persons: map['nb_persons'] != null ? map['nb_persons'] as int : null,
      reminder: map['reminder'] != null ? map['reminder'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plan.fromJson(String source) =>
      Plan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plan(id: $id, userId: $userId, pubId: $pubId, title: $title, dateFrom: $dateFrom, dateTo: $dateTo, timeFrom: $timeFrom, timeTo: $timeTo, nb_persons: $nb_persons, reminder: $reminder)';
  }

  @override
  bool operator ==(covariant Plan other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.pubId == pubId &&
        other.title == title &&
        other.dateFrom == dateFrom &&
        other.dateTo == dateTo &&
        other.timeFrom == timeFrom &&
        other.timeTo == timeTo &&
        other.nb_persons == nb_persons &&
        other.reminder == reminder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        pubId.hashCode ^
        title.hashCode ^
        dateFrom.hashCode ^
        dateTo.hashCode ^
        timeFrom.hashCode ^
        timeTo.hashCode ^
        nb_persons.hashCode ^
        reminder.hashCode;
  }

  DateTime? get parsedDateFrom =>
      dateFrom != null ? DateTime.parse(dateFrom!) : null;
  DateTime? get parsedDateTo => dateTo != null ? DateTime.parse(dateTo!) : null;
}
