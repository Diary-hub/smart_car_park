import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_car_park/utils/helpers/network.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';
import 'package:smart_car_park/utils/loaders/full_screen_loader.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final showPassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read("LastEmail") == '' || localStorage.read("LastEmail") == null
        ? ''
        : localStorage.read("LastEmail");
    password.text =
        localStorage.read("LastPassword") == '' || localStorage.read("LastPassword") == null
            ? ''
            : localStorage.read("LastPassword");
    super.onInit();
  }

  // Login
  Future<void> emailAndPasswordLogin() async {
    try {
      // Start Loader
      KFullScreenLoader.openLoadingDialog("Please Wait!", KImages.processing);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // Validate The Data
      if (loginFormKey.currentState!.validate() != true) {
        KLoaders.errorSnackBar(title: "Problem Occuerd!", message: "Please Fill The Fieldss");

        KFullScreenLoader.stopLoading();
        return;
      }

      // Remember Me Action
      localStorage.write("LastEmail", email.text.trim());
      localStorage.write("LastPassword", password.text);

      // Register User Authentication
      // ignore: unused_local_variable
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text);

      // Stop Loader
      KFullScreenLoader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      KFullScreenLoader.stopLoading();

      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Problem Occuerd!", message: "Please Fill The Fieldss");
      } else {
        KLoaders.errorSnackBar(title: "Problem Occuerd!", message: e.toString());
      }
    }
  }
}
