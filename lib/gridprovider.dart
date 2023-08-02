import 'package:flutter/foundation.dart';

import 'articulos.dart';
import 'lista.dart';

class GridProvider with ChangeNotifier, DiagnosticableTreeMixin {
  List<Articulos> _newArray01 = Lista.articulos;
  List<Articulos> _newArray02 = Lista.articulos;

//  GridProvider(this.newArray01, this.newArray02);
  get newArray01 => _newArray01;
  get newArray02 => _newArray02;

  void setArray01(List<Articulos> newArray01) {
    _newArray01 = newArray01;
    notifyListeners();
  }

  void setArray02(List<Articulos> newArray02) {
    _newArray02 = newArray02;
    notifyListeners();
  }
}
