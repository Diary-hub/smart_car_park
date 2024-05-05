// ignore_for_file: empty_catches

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_car_park/data/repositories/parks/map/park_repository.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';

class ParkController extends GetxController {
  static ParkController get instance => Get.find();
  final parkRepo = Get.put(ParkRepository());

  RxList<ParkModel> allParks = <ParkModel>[].obs;

  RxBool isLoading = false.obs;

  LatLng? currentLocation;

  @override
  void onReady() {
    super.onReady();
    fetchParks();
  }

  Future<void> fetchParks() async {
    try {
      isLoading.value = true;
      final parks = await parkRepo.getParksLocation();

      allParks.assignAll(parks);
    } catch (e) {
      KLoaders.errorSnackBar(title: "There Was A Problem Maps!", message: e);
    } finally {
      isLoading.value = false;
    }
  }
}
