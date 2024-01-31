import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ktp_project/data/repository/ktp_repository.dart';
import 'package:ktp_project/domain/entities/regencies.dart';

import '../../domain/entities/ktp.dart';
import '../../domain/entities/province.dart';
import 'SaveForm.dart';
import 'DisplayPage.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required String? Function(String? value) validator,
  }); //constructor

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}

class SubmitPage extends StatefulWidget {
  @override
  _SubmitPageState createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  final KTPRepository ktpRepository = KTPRepository();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();
  TextEditingController _pekerjaanController = TextEditingController();
  TextEditingController _pendidikanController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Provinces>? provinceItems;
  String? selectedProvince;
  List<Regencies>? regenciesItems;
  String? selectedRegencies;

  @override
  void initState() {
    super.initState();
    // Fetch provinces data from the repository
    _fetchProvincesData();
  }

  Future<void> _fetchProvincesData() async {
    try {
      List<Provinces> data = await ktpRepository.getProvince();
      setState(() {
        provinceItems = data ?? [];
      });
    } catch (e) {
      print('Error fetching province data: $e');
      // Handle error, show a message, or take appropriate action
    }
  }

  Future<void> _fetchRegenciesData() async {
    try {
      List<Regencies> data =
          await ktpRepository.getRegencies(selectedProvince!);
      setState(() {
        regenciesItems = data ?? [];
      });
    } catch (e) {
      print('Error fetching regencies data: $e');
      // Handle error, show a message, or take appropriate action
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: _namaController,
                  labelText: 'Nama',
                  hintText: 'Masukkan Nama Anda Disini',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Wajib di Isi';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 14), // Add spacing between text fields
                // Add other widgets as needed

                CustomTextField(
                  controller: _ttlController,
                  labelText: 'Tempat, Tanggal Lahir',
                  hintText: 'Masukkan Tempat Tanggal Lahir Anda Disini',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tempat, Tanggal Lahir wajib di isi';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 14),

                DropdownButtonFormField<Provinces>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: Text('Pilih Provinsi'),
                  items: provinceItems
                      ?.map((province) => DropdownMenuItem<Provinces>(
                            value: province,
                            child: Text(province.name),
                          ))
                      .toList(),
                  onChanged: (Provinces? newValue) {
                    setState(() {
                      selectedProvince = newValue?.id ?? '';
                      selectedRegencies = null;
                    });
                  },
                ),

                SizedBox(height: 14),

                DropdownButtonFormField<Regencies>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  hint: Text('Pilih Kabupaten'),
                  items: regenciesItems
                      ?.map((regency) => DropdownMenuItem<Regencies>(
                            value: regency,
                            child: Text(regency.name),
                          ))
                      .toList(),
                  onChanged: (Regencies? newValue) {
                    setState(() {
                      selectedRegencies = newValue?.id;
                    });
                  },
                ),
                SizedBox(height: 14),
                CustomTextField(
                  controller: _pekerjaanController,
                  labelText: 'Pekerjaan',
                  hintText: 'Masukkan Pekerjaan Anda Disini',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pekerjaan Wajib di Isi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                CustomTextField(
                  controller: _pendidikanController,
                  labelText: 'Pendidikan',
                  hintText: 'Masukkan Pendidikan Anda Disini',
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pendidikan Wajib di Isi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(
                          'Validation success, proceeding to save data to Hive');

                      final box = await Hive.openBox<KTP>('ktpbox');

                      // Create a KTP object with form data
                      final ktpData = KTP(
                        nama: _namaController.text,
                        ttl: _ttlController.text,
                        // provinsi: provinceItems!.first.name,
                        // regencies: regenciesItems?.isNotEmpty == true
                        //     ? regenciesItems!.first.id
                        //     : null,
                        pekerjaan: _pekerjaanController.text,
                        pendidikan: _pendidikanController.text,
                      );

                      Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPage()),);

                      // Save the KTP data to Hive
                      await box.add(ktpData);

                      // Optionally, clear text controllers
                      _namaController.clear();
                      _ttlController.clear();
                      _pekerjaanController.clear();
                      _pendidikanController.clear();
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// void _saveDataToHive() async {
//   // Get data from controllers
//   String nama = _namaController.text;
//   String ttl = _ttlController.text;
//   String pekerjaan = _pekerjaanController.text;
//   String pendidikan = _pendidikanController.text;
//
//   // Save data to Hive
//   await SaveForm.saveFormData({
//     'nama': nama,
//     'ttl': ttl,
//     'pekerjaan': pekerjaan,
//     'pendidikan': pendidikan,
//   });
//
//   // Optionally, clear text controllers
//   _namaController.clear();
//   _ttlController.clear();
//   _pekerjaanController.clear();
//   _pendidikanController.clear();
//
//   // Navigate to the next page
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => DisplayPage()),
//   );
// }
}
