import 'package:hive/hive.dart';
import 'package:kartal/kartal.dart';
import 'package:tesme_app/data/model/zikir_model.dart';

abstract class LocalStorage {
  Future<void> addZikir({required ZikirModel zikir});
  Future<List<ZikirModel>> getAllZikr();
  Future<ZikirModel> saveZikir({required ZikirModel zikir});
  Future<bool> deleteZikr({required ZikirModel zikir});
  Future<void> saveSelectedZikirCount({required ZikirModel count});
  Future<void> setSelectedZikrCount(int count);
  //Future<int> getSelectedZikrCount();
}

class HiveLocalStorage extends LocalStorage {
  late Box<ZikirModel> zikirBox;
  HiveLocalStorage() {
    zikirBox = Hive.box<ZikirModel>('zikrs');
  }

  @override
  Future<void> addZikir({required ZikirModel zikir}) async {
    await zikirBox.put(zikir.zikirID, zikir);
  }

  @override
  Future<bool> deleteZikr({required ZikirModel zikir}) async {
    await zikir.delete();
    return true;
  }

  @override
  Future<List<ZikirModel>> getAllZikr() async {
    List<ZikirModel> allZikr = <ZikirModel>[];
    allZikr = zikirBox.values.toList();

    return allZikr;
  }

  @override
  Future<ZikirModel> saveZikir({required ZikirModel zikir}) async {
    await zikir.save();
    return zikir;
  }

  @override
  Future<void> saveSelectedZikirCount({required ZikirModel count}) async {
    Box<ZikirModel> zikirBox = Hive.box('zikrs');
    final existingZikir = zikirBox.values.firstWhereOrNull(
      (element) => element.zikirName == count.zikirName,
    );
    if (existingZikir != null) {
      final updatedZikir = ZikirModel(
        zikirID: existingZikir.zikirID,
        zikirName: count.zikirName,
        zikirArabic: count.zikirArabic,
        zikirCount: count.zikirCount,
      );
      await zikirBox.put(existingZikir.key, updatedZikir);
    } else {
      await zikirBox.add(count);
    }
  }

  @override
  Future<void> setSelectedZikrCount(int count) async {
    final box = Hive.box('zikrs');
    await box.put('zikirCount', count);
  }
}
