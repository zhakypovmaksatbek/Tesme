import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'zikir_model.g.dart';

@HiveType(typeId: 1)
class ZikirModel extends HiveObject {
  @HiveField(0)
  String zikirID;

  @HiveField(1)
  final String zikirName;

  @HiveField(2)
  final String zikirArabic;

  @HiveField(3)
  final int zikirCount;

  ZikirModel(
      {required this.zikirID,
      required this.zikirName,
      required this.zikirArabic,
      required this.zikirCount});
  factory ZikirModel.create({
    required String zikirName,
    required String zikirArabic,
    required int zikirCount
  }) {
    return ZikirModel(
        zikirID: const Uuid().v1(),
        zikirName: zikirName,
        zikirArabic: zikirArabic,
        zikirCount: zikirCount);
  }
}
