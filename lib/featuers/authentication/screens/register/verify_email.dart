import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/constants/texts.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/constants/colors.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/utils/helpers/helper_functions.dart';
import 'package:smart_car_park/common/styles/spacing_padding_sizes.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_car_park/featuers/authentication/controllers/register/verify_email_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});
  final String? email;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashColor: Colors.red,
            color: Colors.amber,
            onPressed: () => AuthenticationRepository.instance.logout(),
            icon: const Icon(Icons.clear),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: KSpacingPaddingSizes.paddingWithAppBarHeight,
            child: Column(
              children: [
                Lottie.asset(
                  KImages.verify,
                  width: KHelperFunctions.screenWidth() * 0.6,
                ),
                const SizedBox(height: KSizes.spaceBetweenSections),
                Text(KTexts.verifyTitle,
                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: KSizes.spaceBetweenItems),
                Text(email ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: KColors.secondaryColor)),
                const SizedBox(height: KSizes.spaceBetweenItems),
                Text(KTexts.verifySubTitle,
                    textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: KSizes.spaceBetweenSections),
                SimpleButton(
                  onPressed: controller.checkEmailVerificationStatus,
                  text: KTexts.continueButton,
                ),
                TextButton(
                    onPressed: controller.sendEmailVerification,
                    child: Text(
                      KTexts.resendEmailButton,
                      style:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(color: KColors.primary),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
