// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? user_id;
  String username;
  String lastname;
  int age;
  String email;
  String password;
  String adress;
  String? image;

  User({
    required this.user_id,
    required this.username,
    required this.lastname,
    required this.age,
    required this.email,
    required this.password,
    required this.adress,
     this.image,
  });

  User copyWith({
    int? user_id,
    String? username,
    String? lastname,
    int? age,
    String? email,
    String? password,
    String? adress,
    String? image,
    
  }) {
    return User(
      user_id: user_id ?? this.user_id,
      username: username ?? this.username,
      lastname: lastname ?? this.lastname,
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      adress: adress ?? this.adress,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'username': username,
      'lastname': lastname,
      'age': age,
      'email': email,
      'password': password,
      'adress': adress,
      'image': image,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      username: map['username'] as String,
      lastname: map['lastname'] as String,
      age: map['age'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      adress: map['adress'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(user_id: $user_id, username: $username, lastname: $lastname, age: $age, email: $email, password: $password, adress: $adress, image: $image)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.user_id == user_id &&
      other.username == username &&
      other.lastname == lastname &&
      other.age == age &&
      other.email == email &&
      other.password == password &&
      other.image == image &&
      other.adress == adress;
      
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      username.hashCode ^
      lastname.hashCode ^
      age.hashCode ^
      image.hashCode ^
      email.hashCode ^
      password.hashCode ^
      adress.hashCode;
  }
}
