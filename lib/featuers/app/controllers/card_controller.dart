import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/data/repositories/user/user_repository.dart';
import 'package:smart_car_park/featuers/app/models/card_model.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/utils/helpers/network.dart';
import 'package:smart_car_park/utils/loaders/full_screen_loader.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';

class CardController extends GetxController {
  static CardController get instance => Get.find();
  final _userRepo = UserRepository.instance;

  final isLoading = false.obs;

  RxList<CardModel> allCards = <CardModel>[].obs;

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  GlobalKey<FormFieldState<String>>? cardNumberKey = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>>? cvvCodeKey = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>>? expiryDateKey = GlobalKey<FormFieldState<String>>();
  GlobalKey<FormFieldState<String>>? cardHolderKey = GlobalKey<FormFieldState<String>>();

  RxString cardNumber = ''.obs;
  RxString expireDate = ''.obs;
  RxString cardCvv = ''.obs;
  Rx<TextEditingController> cardNameHolder = TextEditingController().obs;
  TextEditingController cardBankName = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchCards();
  }

  Future<void> saveCard() async {
    try {
      isLoading.value = true;

      // Start Loader
      KFullScreenLoader.openLoadingDialog("Please Wait!", KImages.processing);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      // Validate The Data
      if (key.currentState!.validate() != true) {
        KLoaders.errorSnackBar(title: "Problem Occuerd!", message: "Please Fill The Fields");

        KFullScreenLoader.stopLoading();
        return;
      }

      CardModel card = CardModel(
          cardBrand: cardBankName.text,
          cardCvv: cardCvv.value,
          cardNameHolder: cardNameHolder.value.text,
          cardNumber: cardNumber.value,
          expireDate: expireDate.value);

      await _userRepo.saveCreditCard(card);
      Get.back();
      KLoaders.successSnackBar(title: "Success!", message: "Card Added");
      fetchCards();

      KFullScreenLoader.stopLoading();
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCard(String? id) async {
    try {
      isLoading.value = true;

      // Start Loader
      KFullScreenLoader.openLoadingDialog("Please Wait!", KImages.processing);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KFullScreenLoader.stopLoading();
        return;
      }

      await _userRepo.deleteCreditCard(id);
      KFullScreenLoader.stopLoading();

      KLoaders.warningSnackBar(title: "Success!", message: "Card Deleted");
      fetchCards();
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e.toString());
      KFullScreenLoader.stopLoading();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCards() async {
    try {
      isLoading.value = true;

      final cards = await _userRepo.getAllCards();

      allCards.assignAll(cards);
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e);
    } finally {
      isLoading.value = false;
    }
  }
}
