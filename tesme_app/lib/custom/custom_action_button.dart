// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:tesme_app/provider/theme_provider.dart';

import '../constants/color_constants.dart';

class CustomActionButton extends StatefulWidget {
  const CustomActionButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final void Function() onTap;
  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicFloatingActionButton(
        mini: true,
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: const NeumorphicBoxShape.circle(),
            shadowLightColor: Colors.black38,
            shadowDarkColor: context.watch<ThemeProvider>().isLightTheme
                ? Colors.white60
                : ColorConstants.shadowDarkColor,
            shadowDarkColorEmboss: Colors.black12,
            color: Colors.transparent),
        onPressed: widget.onTap,
        child: const Icon(
          Icons.add,
          color: ColorConstants.greyDark,
        ));
  }
}

class CustomAllertButton extends StatelessWidget {
  const CustomAllertButton(
      {Key? key,
      required this.buttonColor,
      required this.icon,
      required this.title,
      required this.onTap})
      : super(key: key);

  final Color buttonColor;
  final IconData icon;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: onTap,
      style: NeumorphicStyle(
        depth: context.read<ThemeProvider>().isLightTheme ? 3 : -3,
        shape: context.read<ThemeProvider>().isLightTheme
            ? NeumorphicShape.concave
            : NeumorphicShape.flat,
        intensity: 3,
        color: buttonColor,
      ),
      child: Text(
        title,
        style: const TextStyle(
            color: ColorConstants.greyLight,
            fontWeight: FontWeight.bold,
            fontSize: 12),
      ),
    );
  }
}

class NeumorphicTextField extends StatelessWidget {
  const NeumorphicTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: const EdgeInsets.symmetric(vertical: 5),
      style: NeumorphicStyle(
        depth: -2,
        color: context.read<ThemeProvider>().isLightTheme
            ? Colors.white
            : ColorConstants.backgroundColorDark,
        intensity: 0.8,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        onSubmitted: (value) {
          Navigator.of(context).pop();
          if (value.length > 3) {}
        },
        style: const TextStyle(
            color: ColorConstants.greyDark,
            fontWeight: FontWeight.w500,
            fontSize: 16),
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(
              color: ColorConstants.greyDark,
            )),
      ),
    );
  }
}
