import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'package:tesme_app/constants/color_constants.dart';
import 'package:tesme_app/constants/neumorphic_style.dart';
import 'package:tesme_app/provider/provider.dart';

class SelectedZikr extends StatelessWidget {
  const SelectedZikr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) => Neumorphic(
        style: MyNeumorphicStyle(context),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            NeumorphicText(
              provider.selectedZikirArabic,
              style: const NeumorphicStyle(
                depth: 0, //customize depth here
                color: ColorConstants.greyDark,
              ),
              textStyle: NeumorphicTextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
            NeumorphicText(
              provider.selectedZikir,
              style: const NeumorphicStyle(
                depth: 0, //customize depth here
                color: ColorConstants.greyDark,
              ),
              textStyle: NeumorphicTextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
