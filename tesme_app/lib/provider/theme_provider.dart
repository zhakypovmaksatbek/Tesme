import 'package:flutter/material.dart';
import 'package:tesme_app/constants/color_constants.dart';

class ThemeProvider extends ChangeNotifier {
  bool isLightTheme = true;
  bool isTapped = false;
  void changeTapped() {
    isTapped = !isTapped;
    notifyListeners();
  }

  void changeTheme() {
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  ThemeData get currentTheme => isLightTheme
      ? ThemeData.light(useMaterial3: true).copyWith(
          listTileTheme: const ListTileThemeData(
            minLeadingWidth: BorderSide.strokeAlignCenter,
            textColor: ColorConstants.greyDark,
          ),
          dialogBackgroundColor: ColorConstants.greyDark,
          inputDecorationTheme:
              const InputDecorationTheme(fillColor: ColorConstants.primary),
          scaffoldBackgroundColor: ColorConstants.greyLight,
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: ColorConstants.greyDark),
              backgroundColor: ColorConstants.greyLight,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.greyDark,
                  fontSize: 24)))
      : ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: ColorConstants.backgroundColorDark,
          appBarTheme: const AppBarTheme(
              backgroundColor: ColorConstants.backgroundColorDark,
              centerTitle: true,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  fontSize: 24)));
}
