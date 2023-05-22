import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tesme_app/constants/text_constants.dart';
import 'package:tesme_app/custom/custom_action_button.dart';

import 'package:tesme_app/provider/theme_provider.dart';
import 'package:uuid/uuid.dart';

import 'constants/color_constants.dart';
import 'data/local_storage.dart';
import 'data/model/zikir_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late List<ZikirModel> _allZikrs = [];
  late HiveLocalStorage _localStorage;
  @override
  void initState() {
    super.initState();

    _localStorage = HiveLocalStorage();
    _getAllZikrFromDb();
  }

  Future<void> _getAllZikrFromDb() async {
    _allZikrs = await _localStorage.getAllZikr();
    setState(() {});
  }

  final TextEditingController zikirNameController = TextEditingController();

  final TextEditingController zikirArabicNameController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          TextConstants.myZikrs,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomActionButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor:
                          context.read<ThemeProvider>().isLightTheme
                              ? ColorConstants.greyLight
                              : ColorConstants.backgroundColorDark,
                      titleTextStyle: const TextStyle(
                          color: ColorConstants.greyDark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      title: const Text(TextConstants.addZikr),
                      actions: [
                        NeumorphicTextField(
                            controller: zikirNameController,
                            hintText: TextConstants.zikrName),
                        NeumorphicTextField(
                          controller: zikirArabicNameController,
                          hintText: TextConstants.zikrArabicName,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomAllertButton(
                                buttonColor: ColorConstants.primaryDark,
                                icon: Icons.playlist_add_check_outlined,
                                onTap: () async {
                                  if (zikirNameController.text.length < 3 ||
                                      zikirArabicNameController.text.length <
                                          3) {
                                    QuickAlert.show(
                                        context: context,
                                        backgroundColor: context
                                                .read<ThemeProvider>()
                                                .isLightTheme
                                            ? ColorConstants.greyLight
                                            : ColorConstants
                                                .backgroundColorDark,
                                        confirmBtnColor: context
                                                .read<ThemeProvider>()
                                                .isLightTheme
                                            ? ColorConstants.primary
                                            : ColorConstants.primaryDark,
                                        type: QuickAlertType.error,
                                        text: TextConstants.sorry,
                                        textColor: ColorConstants.greyDark,
                                        titleColor: ColorConstants.greyDark,
                                        confirmBtnTextStyle: const TextStyle(
                                            color: ColorConstants.greyLight,
                                            fontWeight: FontWeight.bold),
                                        confirmBtnText: TextConstants.fixIt);
                                  } else {
                                    final newZikir = ZikirModel(
                                        zikirID: const Uuid().v1(),
                                        zikirName: zikirNameController.text,
                                        zikirArabic:
                                            zikirArabicNameController.text,
                                        zikirCount: 0);
                                    _allZikrs.insert(0, newZikir);
                                    Navigator.pop(context);
                                    setState(() {});
                                    zikirNameController.clear();
                                    zikirArabicNameController.clear();
                                    QuickAlert.show(
                                        title: TextConstants.success,
                                        confirmBtnColor: context
                                                .read<ThemeProvider>()
                                                .isLightTheme
                                            ? ColorConstants.primary
                                            : ColorConstants.primaryDark,
                                        context: context,
                                        type: QuickAlertType.success,
                                        text: TextConstants.addedSuccessfully,
                                        confirmBtnText: TextConstants.okay);
                                    await HiveLocalStorage()
                                        .addZikir(zikir: newZikir);
                                  }
                                },
                                title: TextConstants.add),
                            CustomAllertButton(
                                buttonColor: ColorConstants.primary,
                                icon: Icons.cancel_presentation_outlined,
                                onTap: () {
                                  Navigator.pop(context);
                                  zikirNameController.clear();
                                  zikirArabicNameController.clear();
                                },
                                title: TextConstants.cancel),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _getAllZikrFromDb,
        color: ColorConstants.greyDark,
        backgroundColor: context.read<ThemeProvider>().isLightTheme
            ? ColorConstants.greyLight
            : ColorConstants.backgroundColorDark,
        child: Padding(
          padding: context.horizontalPaddingNormal,
          child: ListView.builder(
            itemCount: _allZikrs.length,
            itemBuilder: (BuildContext context, int index) {
              var selectedZikr = _allZikrs[index];

              return Dismissible(
                key: Key(selectedZikr.zikirID),
                onDismissed: (direction) {
                  if (index < _allZikrs.length) {
                    _allZikrs.removeAt(index);
                    _localStorage.deleteZikr(zikir: selectedZikr);
                  } else {
                    return;
                  }
                },
                child: Neumorphic(
                  margin: const EdgeInsets.all(10),
                  style: _neumorphicStyle(context),
                  child: ListTile(
                    leading: Text(
                      _allZikrs[index].zikirCount.toString(),
                      style: context.textTheme.titleLarge?.copyWith(
                          color: ColorConstants.greyDark,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Center(child: Text(_allZikrs[index].zikirName)),
                    title: Center(
                      child: Text(
                        _allZikrs[index].zikirArabic,
                        style: context.textTheme.bodyLarge?.copyWith(
                            color: ColorConstants.greyDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  NeumorphicStyle _neumorphicStyle(BuildContext context) {
    return NeumorphicStyle(
        shadowLightColor: context.read<ThemeProvider>().isLightTheme
            ? Colors.white70
            : ColorConstants.shadowDarkColor,
        shape: NeumorphicShape.flat,
        intensity: 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 4,
        lightSource: LightSource.top,
        color: context.read<ThemeProvider>().isLightTheme
            ? ColorConstants.greyLight
            : const Color(0xFF222222));
  }
}
