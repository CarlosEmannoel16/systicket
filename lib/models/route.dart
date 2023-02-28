import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'city.dart';

class Routes {
  final int id;
  final int origem;
  final int destiny;
  final String departure_time;
  final String arrive_time;
  final String value;
  final String origemName;
  final String destinyName;
  // final int router_id;

  const Routes({
    required this.id,
    required this.origem,
    required this.destiny,
    required this.departure_time,
    required this.arrive_time,
    required this.value,
    required this.origemName,
    required this.destinyName
    // required this.router_id
  });

  factory Routes.fromJson(Map<String, dynamic> json) {
    return Routes(
        id: json['id'],
        origem: json['origem'],
        destiny: json['destiny'],
        arrive_time: json['arrive_time'],
        departure_time: json['departure_time'],
        value: json['value'],
        origemName: json['origemName'],
        destinyName: json['destinyName']

        // router_id: json['router_id'] ? json['router_id'] : 0
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['origem'] = this.origem;
    data['destiny'] = this.destiny;
    data['departure_time'] = this.departure_time;
    data['arrive_time'] = this.arrive_time;
    data['value'] = this.value;
    data['origemName'] = this.origemName;
    data['destinyName'] = this.destinyName;


    // data['route_id'] = this.router_id;

    return data;
  }
}