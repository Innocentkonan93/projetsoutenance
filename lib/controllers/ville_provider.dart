import 'package:flutter/cupertino.dart';
import 'package:pharm_point/models/villes.dart';

class VilleProvider with ChangeNotifier {
  bool _isProcessing = true;
  List<Villes> _listVilles = [];

  bool get isProcessing => _isProcessing;
  List<Villes> get listVilles {
    return [..._listVilles];
  }

  setVilleList(List<Villes> list) {
    _listVilles = list;
    notifyListeners();
  }

}
