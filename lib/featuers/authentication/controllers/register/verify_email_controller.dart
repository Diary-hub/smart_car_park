import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_car_park/utils/constants/texts.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/common/widgets/simple_page.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  //Send Every Time The Screen is Opened
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForVerification();
    super.onInit();
  }

  // Send Email Verfication Link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerfication();
      KLoaders.successSnackBar(
          title: "!ئەکاونتەکەت پشتڕاست بکەرەوە",
          message: "تکایە سێری ئیمەیڵەکەت بکە و ئەکاونتەکەت پشتڕاست بکەرەوە");
    } catch (e) {
      KLoaders.errorSnackBar(title: "!کێشەیەک ڕویدا", message: e.toString());
    }
  }

  // Timer to automatically redirect on email Verfification
  setTimerForVerification() async {
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser?.emailVerified ?? false) {
        timer.cancel();
        Get.off(
          () => const SimpleScreen(
            buttonText: KTexts.continueButton,
            image: KImages.emailVerified,
            subtitle: KTexts.verifyDoneSubTitle,
            title: KTexts.verifyDoneTitle,
          ),
        );
      }
    });
  }

  // Manually Check if Email Verified

  checkEmailVerificationStatus() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(
          () => const SimpleScreen(
            buttonText: KTexts.continueButton,
            image: KImages.verifyAccountDoneImage,
            subtitle: KTexts.verifyDoneSubTitle,
            title: KTexts.verifyDoneTitle,
          ),
        );
      } else {
        KLoaders.warningSnackBar(
            title: "!ببورە دوبارە هەوڵبدەرەوە", message: "تکایە ئەکاونتەکەت پشتڕاست بکەرەوە");
      }
    } catch (e) {
      KLoaders.errorSnackBar(title: "!کێشەیەک ڕویدا", message: e.toString());
    }
  }
}
