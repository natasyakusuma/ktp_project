import 'package:hive/hive.dart';

part 'ktp.g.dart';

@HiveType(typeId: 1)
class KTP{
  KTP ({this.nama, this.ttl, this.pekerjaan, this.pendidikan});

  @HiveField(0)
  String? nama;

  @HiveField(1)
  String? ttl;

  @HiveField(2)
  String? provinsi;

  @HiveField(3)
  String? kabupaten;

  @HiveField(4)
  String? pekerjaan;

  @HiveField(5)
  String? pendidikan;
}