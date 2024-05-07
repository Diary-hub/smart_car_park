import 'package:get/get.dart';
import 'package:smart_car_park/data/repositories/parks/history/history_repository.dart';
import 'package:smart_car_park/featuers/app/models/history_model.dart';
import 'package:smart_car_park/featuers/personalization/controllers/user_controller.dart';
import 'package:smart_car_park/utils/constants/images.dart';
import 'package:smart_car_park/utils/helpers/network.dart';
import 'package:smart_car_park/utils/loaders/full_screen_loader.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';

class HistoryController extends GetxController {
  static HistoryController get instance => Get.find();

  final _historyRepo = Get.put(HistoryRepository());

  final isLoading = false.obs;

  RxList<HistoryModel?> allHistory = <HistoryModel>[].obs;
  RxList<HistoryModel?> allHistory2 = <HistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> saveHistory(String location, String slot, String price, String date) async {
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

      HistoryModel card = HistoryModel(
          location: location,
          slot: slot,
          price: price,
          date: date,
          userID: UserController.instance.user.value.id);

      await _historyRepo.saveParkHistory(card);
      Get.back();
      KLoaders.successSnackBar(title: "Success!", message: "Card Added");
      fetchHistory();

      KFullScreenLoader.stopLoading();
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteHistory(String? id) async {
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

      await _historyRepo.deleteParkHistory(id!);
      KFullScreenLoader.stopLoading();

      KLoaders.warningSnackBar(title: "Success!", message: "Card Deleted");
      fetchHistory();
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e.toString());
      KFullScreenLoader.stopLoading();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;

      final history = await _historyRepo.getHistory();

      allHistory.assignAll(history);
      allHistory2.assignAll(<HistoryModel>[]);
      for (HistoryModel? element in allHistory) {
        if (element!.userID == UserController.instance.user.value.id) {
          allHistory2.add(element);
        }
      }
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem!", message: e);
    } finally {
      isLoading.value = false;
    }
  }
}
