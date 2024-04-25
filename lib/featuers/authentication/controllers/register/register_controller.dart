import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';
import 'package:smart_car_park/utils/helpers/network.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';
import 'package:smart_car_park/utils/loaders/full_screen_loader.dart';
import 'package:smart_car_park/data/repositories/user/user_repository.dart';
import 'package:smart_car_park/featuers/personalization/models/user_model.dart';
import 'package:smart_car_park/featuers/authentication/screens/register/verify_email.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> register() async {
    try {
      // Start Loader
      KFullScreenLoader.openLoadingDialog("تکایە چاوەڕوان بە", KImages.processing);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // Validate The Data
      if (registerFormKey.currentState!.validate() != true) {
        KLoaders.errorSnackBar(title: "!کێشەیەک ڕویدا", message: "تکایە زانیاریەکان پڕ بکەرەوە");
        if (password.text != confirmPassword.text) {
          KFullScreenLoader.stopLoading();
          KLoaders.errorSnackBar(title: "وشەی نهێنی ئەکسان نین");
          return;
        }

        KFullScreenLoader.stopLoading();
        return;
      }

      // Register User Authentication
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(email.text.trim(), password.text);

      var now = DateTime.now();
      String formattedDate = KFormatter.formatDate(now);

      // Save User Data
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phoneNumber: phone.text.trim(),
        email: email.text.trim(),
        profilePicture: '',
        dateOfAccount: formattedDate,
        gender: '',
        dateOfBirth: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Show sucess
      KLoaders.successSnackBar(
          title: "پیرۆزە",
          message: 'ئەکاونتەکەت دروستکرا، تکایە ئەکاونەتەکە بشتڕاست بکەوە بۆ بەردەوامبوون');

      // Go to verify
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      // Error
      KFullScreenLoader.stopLoading();

      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "!کێشەیەک ڕویدا", message: "تکایە زانیاریەکان پڕ بکەرەوە");
      } else {
        KLoaders.errorSnackBar(title: "!کێشەیەک ڕویدا", message: e.toString());
      }
    }
  }
}
