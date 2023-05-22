import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:tesme_app/constants/color_constants.dart';
import 'package:tesme_app/constants/text_constants.dart';
import 'package:tesme_app/provider/theme_provider.dart';

class DarkLightButton extends StatelessWidget {
  const DarkLightButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) => NeumorphicButton(
        tooltip: provider.isLightTheme
            ? TextConstants.lightMode
            : TextConstants.darkMode,
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: const NeumorphicBoxShape.circle(),
            shadowLightColor: Colors.black38,
            shadowDarkColor: provider.isLightTheme
                ? Colors.white60
                : ColorConstants.shadowDarkColor,
            shadowDarkColorEmboss: Colors.black12,
            color: Colors.transparent),
        child: Icon(
          provider.isLightTheme
              ? Icons.light_mode_outlined
              : Icons.dark_mode_outlined,
          color:
              provider.isLightTheme ? ColorConstants.greyDark : Colors.white60,
        ),
        onPressed: () {
          provider.changeTheme();
        },
      ),
    );
  }
}
