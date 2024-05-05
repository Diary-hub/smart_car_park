import 'package:flutter/material.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';
import 'package:smart_car_park/featuers/personalization/screens/settings/widgets/pile.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/utils/helpers/helper_functions.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    return Scaffold(
      drawer: CustomDrawerPrimary(
        sH: sH,
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Pile(
                  iconData: Icons.notifications,
                  onTap: () {},
                  title: "Notifications",
                ),
                Pile(
                  iconData: Icons.language,
                  onTap: () {},
                  title: "Language",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Pile(
                  iconData: Icons.question_mark,
                  onTap: () {
                    KHelperFunctions.showAlert("TERMS OF USE", 'This is the Terms of Use ');
                  },
                  title: "Terms of Use",
                ),
                Pile(
                  iconData: Icons.shield,
                  onTap: () {
                    KHelperFunctions.showAlert(
                        "PRIVACY AND POLICY", 'This is the Privacy and Policy ');
                  },
                  title: "Privacy and Policy",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
