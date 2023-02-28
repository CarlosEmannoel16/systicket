import 'package:flutter/foundation.dart';
import 'dart:convert';

class Cities {
  final int id;
  final String name;
  final int state_id;

  const Cities({
    required this.id,
    required this.name,
    required this.state_id
  });

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
        id: json['id'],
        name: json['name'],
        state_id: json['state_id']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state_id'] = this.state_id;

    return data;
  }
}