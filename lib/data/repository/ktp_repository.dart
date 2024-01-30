import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/province.dart';


abstract class AbstractKTPRepository {
  Future<List<Provinces>> getProvince();
}

class KTPRepository implements AbstractKTPRepository {
  @override

  Future<List<Provinces>> getProvince() async {
    String data = await rootBundle.loadString('assets/provinces.json');
    List<dynamic> jsonList = jsonDecode(data);

    List<Provinces> provinces = jsonList.map((json) {
      return Provinces(
          id: json['id'],
          name: json['name'],
          altName: json['altName'],
          latitude: json['latitude'],
          longitude: json['longitude']);

    }).toList();

    return provinces;
  }
}




