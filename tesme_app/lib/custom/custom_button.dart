// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:tesme_app/constants/neumorphic_style.dart';

import '../constants/color_constants.dart';
import '../provider/theme_provider.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.tooltip,
  }) : super(key: key);
  final void Function() onTap;
  final IconData icon;
  final String tooltip;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => NeumorphicButton(
        onPressed: onTap,
        tooltip:tooltip ,
        style: MyNeumorphicStyle(context),
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          icon,
          color: ColorConstants.greyLight3,
          size: 30,
        ),
      ),
    );
  }
}
