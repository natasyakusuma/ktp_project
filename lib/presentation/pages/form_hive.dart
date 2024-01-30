import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SaveForm extends ChangeNotifier{
  static const _myBox = 'form_data';

  SaveForm(){
    _init(); //initialisasi hive
  }

  Future<void> _init() async{
    await Hive.initFlutter();
    var box = await Hive.openBox(_myBox);
    notifyListeners();
  }
}