import 'package:flutter/material.dart';

import 'package:tesme_app/data/local_storage.dart';
import '../data/model/zikir_model.dart';

class MyProvider extends ChangeNotifier {
  final LocalStorage localStorage;
  MyProvider(this.localStorage);

  final FixedExtentScrollController controller = FixedExtentScrollController();

  List<ZikirModel> allZikrs = [];

  Future<void> getAllZikrs() async {
    allZikrs = await localStorage.getAllZikr();
    notifyListeners();
  }

  Future<void> addZikir(ZikirModel zikir) async {
    await localStorage.addZikir(zikir: zikir);
    notifyListeners();
  }

  int selectedZikrCount = 0;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  Future<void> setSelectedZikrCount(int count) async {
    selectedZikrCount = count;
    await localStorage.setSelectedZikrCount(count);
    notifyListeners();
  }

  void incrementZikr() async {
    selectedZikrCount++;
    notifyListeners();
  }

  void restart() {
    selectedZikrCount = 0;
    notifyListeners();
  }

  String selectedZikirArabic = 'اَللّٰه';
  String selectedZikir = 'Аллах';
  void setSelectedItem(String zikirName) {
    selectedZikir = zikirName;
    notifyListeners();
  }

  void setSelectedItemArabic(String zikirName) {
    selectedZikirArabic = zikirName;
    notifyListeners();
  }
}
