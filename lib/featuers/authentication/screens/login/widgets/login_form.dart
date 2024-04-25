import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/constants/texts.dart';
import 'package:smart_car_park/utils/validators/validation.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';
import 'package:smart_car_park/featuers/authentication/screens/register/register.dart';
import 'package:smart_car_park/featuers/authentication/controllers/login/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          CustomInputField(
            controller: controller.email,
            labelText: KTexts.emailField,
            validator: (value) => KValidator.validateEmail(value),
            obscureText: false,
            prefixIcon: const Icon(Icons.email_outlined),
          ),
          const SizedBox(height: KSizes.spaceBetweenInputFields),
          Obx(
            () => CustomInputField(
              controller: controller.password,
              validator: (value) => KValidator.validateField("Password", value),
              labelText: KTexts.passwordField,
              prefixIcon: const Icon(Icons.password_rounded),
              obscureText: controller.showPassword.value,
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.showPassword.value = !controller.showPassword.value;
                  },
                  icon: controller.showPassword.value
                      ? const Icon(Iconsax.eye_slash)
                      : const Icon(Iconsax.eye)),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => {
//  Get.to(() => const ForgotPasswrdScreen());
                },
                child: Text(
                  KTexts.loginForgotPassword,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: KSizes.spaceBetweenSections / 4),
          SimpleButton(
            onPressed: () => controller.emailAndPasswordLogin(),
            text: KTexts.loginButton,
          ),
          SizedBox(
              height:
                  (KDeviceUtils.getBottomNavigationBarHeight() + KDeviceUtils.getAppBarHeight()) /
                      1.4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(KTexts.loginNotRegister, style: Theme.of(context).textTheme.labelSmall),
              TextButton(
                onPressed: () => Get.offAll(() => const RegisterScreen()),
                child: Text(
                  KTexts.loginRegisterHere,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
