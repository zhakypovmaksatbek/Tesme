import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:tesme_app/data/local_storage.dart';
import 'package:tesme_app/data/model/zikir_model.dart';
import 'package:tesme_app/history_page.dart';
import 'package:tesme_app/provider/provider.dart';
import 'package:tesme_app/provider/theme_provider.dart';

import 'home_page.dart';

final List<ZikirModel> defaultZikrs = [
  ZikirModel(
    zikirID: '1',
    zikirName: 'Субхааналлах',
    zikirArabic: 'سُبْحَانَ اللّٰهِ',
    zikirCount: 0,
  ),
  ZikirModel(
    zikirID: '1',
    zikirName: 'Алхамдулиллах',
    zikirCount: 0,
    zikirArabic: 'اَلْحَمْدُلِلّٰهِ',
  ),
  ZikirModel(
      zikirID: '1',
      zikirName: 'Аллаху Акбар',
      zikirArabic: ' اَللّٰهُ أَكْبَرُ',
      zikirCount: 0),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ZikirModelAdapter());
  var zikirBox = await Hive.openBox<ZikirModel>('zikrs');
  if (zikirBox.isEmpty) {
    zikirBox.addAll(defaultZikrs);
  }

  GetIt.instance.registerSingleton<LocalStorage>(HiveLocalStorage());

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MyProvider>(
        create: (context) => MyProvider(HiveLocalStorage())),
    ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasbih App',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().currentTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/history': (context) => const HistoryPage()
      },
      home: const HomePage(),
    );
  }
}
