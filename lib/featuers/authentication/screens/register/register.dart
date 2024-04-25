import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/constants/texts.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/styles/spacing_padding_sizes.dart';
import 'package:smart_car_park/featuers/authentication/screens/login/login.dart';
import 'package:smart_car_park/featuers/authentication/screens/register/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: KSpacingPaddingSizes.paddingWithAppBarHeight,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      KTexts.registerTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
                const SizedBox(height: KSizes.defaultSpace - 5),
                Row(
                  children: [
                    Text(
                      KTexts.registerSubTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                const SizedBox(height: KSizes.defaultSpace - 5),
                const RegisterForm(),
                SizedBox(
                    height: (KDeviceUtils.getBottomNavigationBarHeight() +
                            KDeviceUtils.getAppBarHeight()) /
                        2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(KTexts.registerHaveAccount, style: Theme.of(context).textTheme.labelSmall),
                    TextButton(
                      onPressed: () => Get.offAll(() => const LoginScreen()),
                      child: Text(
                        KTexts.registerLoginHere,
                        style:
                            Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.orange),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
