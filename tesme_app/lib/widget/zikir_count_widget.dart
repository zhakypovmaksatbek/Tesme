import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:tesme_app/constants/color_constants.dart';

import '../provider/provider.dart';
import '../provider/theme_provider.dart';

class ZikirCountWidget extends StatelessWidget {
  const ZikirCountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) => Container(
        child: Neumorphic(
          style: _myStyle(context),
          padding: const EdgeInsets.all(30),
          child: NeumorphicText(
            provider.selectedZikrCount.toString(),
            style: const NeumorphicStyle(
              depth: 1, //customize depth here
              color: ColorConstants.greyDark,
            ),
            textStyle:
                NeumorphicTextStyle(fontSize: 60, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  NeumorphicStyle _myStyle(BuildContext context) {
    return NeumorphicStyle(
      shadowLightColor: context.read<ThemeProvider>().isLightTheme
          ? Colors.white
          : ColorConstants.shadowDarkColor,
      shape: NeumorphicShape.flat,
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      depth: context.read<ThemeProvider>().isLightTheme ? 3 : 1,
      lightSource: LightSource.bottomRight,
      intensity: 1,
      color: context.watch<ThemeProvider>().isLightTheme
          ? ColorConstants.greyLight
          : ColorConstants.backgroundColorDark,
    );
  }
}
