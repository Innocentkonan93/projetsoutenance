import 'package:flutter/cupertino.dart';
import 'package:pharm_point/models/pharms.dart';
import 'package:pharm_point/models/villes.dart';

class PharmsProvider with ChangeNotifier {
  bool _isProcessing = true;
  List<Pharms> _listPharms = [];

  bool get isProcessing => _isProcessing;
  List<Pharms> get listPharms {
    return [..._listPharms];
  }

  setPharmsList(List<Pharms> list) {
    _listPharms = list;
    notifyListeners();
  }

  // pharmByVille(String id) {
  //   listPharms.where((element) => element.idVille == id).toList();
  // }
}
