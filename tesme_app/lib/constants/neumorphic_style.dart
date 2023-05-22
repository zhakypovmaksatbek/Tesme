import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import 'color_constants.dart';

class MyNeumorphicStyle extends NeumorphicStyle {
  MyNeumorphicStyle(BuildContext context)
      : super(
          shadowLightColor: context.watch<ThemeProvider>().isLightTheme
              ? Colors.white
              : ColorConstants.shadowDarkColor,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: context.watch<ThemeProvider>().isLightTheme ? 3 : 2,
          lightSource: LightSource.bottomRight,
          intensity: 1,
          color: context.watch<ThemeProvider>().isLightTheme
              ? ColorConstants.greyLight
              : ColorConstants.backgroundColorDark,
        );
}
