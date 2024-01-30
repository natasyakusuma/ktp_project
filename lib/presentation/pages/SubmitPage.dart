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
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Provinces>? provinsiItems;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(10.0),
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
              ElevatedButton(
                onPressed: () {
                  _saveDataToHive();
                },
                child: Text('Save Data to Hive'),
              ),
            ],
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
