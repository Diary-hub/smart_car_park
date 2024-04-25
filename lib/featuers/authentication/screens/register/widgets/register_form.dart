import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/constants/texts.dart';
import 'package:smart_car_park/utils/validators/validation.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';
import 'package:smart_car_park/featuers/authentication/controllers/register/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomInputField(
                    validator: (value) => KValidator.validateField(KTexts.firstNameField, value),
                    controller: controller.firstName,
                    labelText: KTexts.firstNameField,
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    obscureText: false),
              ),
              const SizedBox(width: KSizes.defaultSpace),
              Expanded(
                child: CustomInputField(
                    validator: (value) => KValidator.validateField(KTexts.lastNameField, value),
                    controller: controller.lastName,
                    labelText: KTexts.lastNameField,
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    obscureText: false),
              ),
            ],
          ),
          const SizedBox(height: KSizes.defaultSpace),
          CustomInputField(
              validator: (value) => KValidator.validatePhoneNumber(value),
              controller: controller.phone,
              labelText: KTexts.phoneNumberField,
              prefixIcon: const Icon(Icons.phone_android),
              obscureText: false),
          const SizedBox(height: KSizes.defaultSpace),
          CustomInputField(
              validator: (value) => KValidator.validateEmail(value),
              controller: controller.email,
              labelText: KTexts.registerEmailField,
              prefixIcon: const Icon(Icons.email_outlined),
              obscureText: false),
          const SizedBox(height: KSizes.defaultSpace),
          Obx(
            () => CustomInputField(
              validator: (value) => KValidator.validatePassword(value),
              controller: controller.password,
              obscureText: controller.hidePassword.value,
              labelText: KTexts.passwordField,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                icon: controller.hidePassword.value
                    ? const Icon(Iconsax.eye_slash)
                    : const Icon(Iconsax.eye),
              ),
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Obx(
            () => CustomInputField(
              validator: (value) => KValidator.validatePassword(value),
              controller: controller.confirmPassword,
              obscureText: controller.hideConfirmPassword.value,
              labelText: KTexts.passwordRepeatField,
              prefixIcon: const Icon(Icons.lock_clock_outlined),
              suffixIcon: IconButton(
                  onPressed: () =>
                      controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                  icon: controller.hideConfirmPassword.value
                      ? const Icon(Iconsax.eye_slash)
                      : const Icon(Iconsax.eye)),
            ),
          ),
          const SizedBox(height: KSizes.spaceBetweenSections),
          SimpleButton(
            onPressed: () => controller.register(),
            text: KTexts.registerButton,
          ),
        ],
      ),
    );
  }
}
