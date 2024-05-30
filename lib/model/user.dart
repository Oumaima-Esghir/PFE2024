// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  int? user_id;
  String name;
  String role;
  String username;
  String email;
  String password;

  User({
    required this.user_id,
    required this.name,
    required this.role,
    required this.username,
    required this.email,
    required this.password,
  });

  User copyWith({
    int? user_id,
    String? name,
    String? role,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      role: role ?? this.role,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'name': name,
      'role': role,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      user_id: map['user_id'] as int,
      name: map['name'] as String,
      role: map['role'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(user_id: $user_id, name: $name, role: $role, username: $username, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.user_id == user_id &&
      other.name == name &&
      other.role == role &&
      other.username == username &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      name.hashCode ^
      role.hashCode ^
      username.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
