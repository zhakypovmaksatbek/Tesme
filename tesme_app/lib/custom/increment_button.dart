// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../constants/color_constants.dart';
import '../provider/theme_provider.dart';

class IncrementButton extends StatelessWidget {
  const IncrementButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, child) => NeumorphicButton(
        onPressed: onTap,
        style: NeumorphicStyle(
            intensity: 0.99,
            shadowLightColor: provider.isLightTheme
                ? Colors.white
                : ColorConstants.shadowDarkColor,
            color: provider.isLightTheme
                ? ColorConstants.greyLight
                : ColorConstants.backgroundColorDark,
            shape: NeumorphicShape.flat,
            lightSource: LightSource.bottomRight,
            boxShape: const NeumorphicBoxShape.circle(),
            depth: provider.isLightTheme ? 5 : 1),
        padding: const EdgeInsets.all(12.0),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(
            Icons.add,
            color: ColorConstants.greyLight3,
            size: 90,
          ),
        ),
      ),
    );
  }
}
