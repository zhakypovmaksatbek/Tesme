import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:kartal/kartal.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:tesme_app/constants/color_constants.dart';
import 'package:tesme_app/constants/neumorphic_style.dart';
import 'package:tesme_app/constants/text_constants.dart';
import 'package:tesme_app/custom/dark_light_button.dart';
import 'package:tesme_app/custom/increment_button.dart';

import 'package:tesme_app/history_page.dart';
import 'package:tesme_app/provider/provider.dart';
import 'package:tesme_app/widget/selected_zikir_widget.dart';
import 'package:vibration/vibration.dart';

import 'custom/custom_button.dart';
import 'data/local_storage.dart';
import 'data/model/zikir_model.dart';
import 'widget/zikir_count_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text(TextConstants.zikirApp),
            actions: const [DarkLightButton()],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _allZikrs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NeumorphicButton(
                        onPressed: () {
                          provider.restart();
                          provider.setSelectedItemArabic(
                              _allZikrs[index].zikirArabic);
                          provider.setSelectedItem(_allZikrs[index].zikirName);
                          _localStorage.saveSelectedZikirCount(
                              count: ZikirModel.create(
                                  zikirName: _allZikrs[index].zikirName,
                                  zikirArabic: _allZikrs[index].zikirArabic,
                                  zikirCount: provider.selectedZikrCount));
                        },
                        style: MyNeumorphicStyle(context),
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          _allZikrs[index].zikirArabic,
                          style: context.textTheme.bodyLarge?.copyWith(
                              color: ColorConstants.greyDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SelectedZikr(),
              const ZikirCountWidget(),
              IncrementButton(
                onTap: () async {
                  provider.incrementZikr();
                  ZikirModel zikirModel = ZikirModel.create(
                    zikirName: provider.selectedZikir,
                    zikirArabic: provider.selectedZikirArabic,
                    zikirCount: provider.selectedZikrCount,
                  );
                  await _localStorage.saveSelectedZikirCount(count: zikirModel);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtons(
                      tooltip: TextConstants.getData,
                      onTap: () => _getAllZikrFromDb(),
                      icon: Icons.get_app_rounded),
                  CustomButtons(
                      tooltip: TextConstants.zikirPage,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const HistoryPage(),
                          ),
                        );
                        Vibration.vibrate(duration: 10);
                      },
                      icon: Icons.list_outlined),
                  CustomButtons(
                    tooltip: TextConstants.refresh,
                    icon: Icons.restart_alt_outlined,
                    onTap: () {
                      context.read<MyProvider>().restart();
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
