import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveForm {
  static const _myBox = 'SubmitForm';

  static Future<void> saveFormData(Map<String, dynamic> formData) async {
    var box = await Hive.openBox(_myBox);
    await box.put('formData', formData);
  }

  static Future<Map<String, dynamic>?> getFormData() async {
    var box = await Hive.openBox(_myBox);
    return box.get('formData');
  }
}
