import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';
import 'package:smart_car_park/data/repositories/user/user_repository.dart';
import 'package:smart_car_park/featuers/personalization/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final userRepository = Get.put(UserRepository());

  final imageUploading = false.obs;

  final hidePassword = true.obs;
  final reEmail = TextEditingController();
  final rePassword = TextEditingController();
  GlobalKey<FormState> reFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  // Get User Data
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserData();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Upload User Image After Pick
  Future<void> uploadUserImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70, maxWidth: 512, maxHeight: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        //Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleUserModel(json);

        user.value.profilePicture = imageUrl;
        user.refresh();

        KLoaders.successSnackBar(title: "Success!", message: "Profile Image Changed");
      }
    } catch (e) {
      KLoaders.errorSnackBar(title: "There was a problem!", message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
