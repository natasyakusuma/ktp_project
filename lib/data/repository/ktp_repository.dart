import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:ktp_project/domain/entities/regencies.dart';

import '../../domain/entities/province.dart';


abstract class AbstractKTPRepository {
  Future<List<Provinces>> getProvince();
  Future<List<Regencies>> getRegencies();

}


class KTPRepository implements AbstractKTPRepository {
  @override
  Future<List<Provinces>> getProvince() async {
    String data = await rootBundle.loadString('assets/provinces.json');
    List<dynamic> jsonList = jsonDecode(data);
    print('DATA REPO PROVINSI ${data}');
    List<Provinces> provinces = jsonList.map((json) {
      return Provinces( // pakai null safety buat jaga jaga
          id: json['id'] ?? '',
          name: json['name'] ?? '',
          altName: json['altName'] ?? '',
          latitude: json['latitude'] ?? '',
          longitude: json['longitude'] ?? '');
    }).toList();

    return provinces;
  }
  @override
  Future<List<Regencies>> getRegencies() async {
    String data = await rootBundle.loadString('assets/regencies.json');
    List<dynamic> jsonList = jsonDecode(data);

    List<Regencies> regencies = jsonList.map((json) {
      return Regencies(
        id: json['id'],
        provinceId: json['provinceId'],
        name: json['name'],
        altName: json['altName'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
    }).toList();
    return regencies;
  }
}





