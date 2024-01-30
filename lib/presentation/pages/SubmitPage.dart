import 'package:flutter/material.dart';
import 'package:ktp_project/data/repository/ktp_repository.dart';

import '../../domain/entities/province.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

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

  @override
  void initState() {
    super.initState();
    // Fetch provinces data from the repository
    _fetchProvincesData();
  }

  Future<void> _fetchProvincesData() async {
    try {
      List<Provinces>? data = await ktpRepository.getProvince();
      provinceItems = data ?? [];
      setState(() {});
    } catch (e) {
      print('Error fetching province data: $e');
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
                ),
                SizedBox(height: 14), // Add spacing between text fields
                // Add other widgets as needed
                CustomTextField(
                  controller: _ttlController,
                  labelText: 'Tempat, Tanggal Lahir',
                  hintText: 'Masukkan Tempat Tanggal Lahir Anda Disini',
                ),
                SizedBox(height: 14),
                DropdownButtonFormField<Provinces>(
                  hint: Text('Pilih Provinsi'),
                  items: provinceItems?.map((province) => DropdownMenuItem<Provinces>(
                      value: province,
                      child: Text(province.name),)).toList(),
                  onChanged: (Provinces? newValue) {
                    setState(() {
                      selectedProvince = newValue?.id ?? '';
                    });
                  },
                ),
                SizedBox(height: 14),
                CustomTextField(
                  controller: _pekerjaanController,
                  labelText: 'Pekerjaan',
                  hintText: 'Masukkan Pekerjaan Anda Disini',
                ),
                SizedBox(height: 14),
                CustomTextField(
                  controller: _pendidikanController,
                  labelText: 'Pendidikan',
                  hintText: 'Masukkan Pendidikan Anda Disini',
                ),
                SizedBox(height: 14),
                ElevatedButton(
                  onPressed: () {
                    _saveDataToHive();
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

  void _saveDataToHive() {
    // Get data from controllers
    String nama = _namaController.text;
    String ttl = _ttlController.text;

    // Save data to Hive (replace with your own logic)
    // _box.put('nama', nama);
    // _box.put('ttl', ttl);

    // Optionally, clear text controllers
    _namaController.clear();
    _ttlController.clear();
  }
}
