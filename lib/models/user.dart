import 'package:flutter/foundation.dart';
import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String type;
  final String forget;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.type,
    required this.forget
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        phone: json['phone'],
        type: json['type'],
        forget: json['forget']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['forget'] = this.forget;

    return data;
  }
}