// ignore_for_file: empty_catches
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_car_park/data/repositories/parks/map/park_repository.dart';
import 'package:smart_car_park/featuers/app/models/autocomplate_prediction.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/featuers/app/models/place_auto_complate_response.dart';
import 'package:smart_car_park/utils/loaders/snack_loaders.dart';
import 'package:http/http.dart' as http;

class ParkController extends GetxController {
  static ParkController get instance => Get.find();
  final parkRepo = Get.put(ParkRepository());

  RxList<ParkModel> allParks = <ParkModel>[].obs;

  RxList<AutocompletePrediction> placePredictions = <AutocompletePrediction>[].obs;
  RxBool isLoading = false.obs;

  Location locationControler = Location();
  LatLng? currentLocation;

  GoogleMapController? mapController;
  Rx<BitmapDescriptor> customIcon = BitmapDescriptor.defaultMarker.obs;

  @override
  void onReady() {
    super.onReady();
    fetchParks();
    getBytesFromAsset('assets/images/markers/parkMark.png');
  }

  (double, int) findSmallest(List<double> numbers) {
    if (numbers.isEmpty) {
      throw ArgumentError('List cannot be empty');
    }

    double smallest = numbers[0]; // Assume the first element is the smallest
    int index = 0;
    for (int i = 1; i < numbers.length; i++) {
      if (numbers[i] < smallest) {
        smallest = numbers[i];
        index = i;
      }
    }

    return (smallest, index);
  }

  Future<void> getBytesFromAsset(String path) async {
    // make sure to initialize before map loading
    await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(70, 70)), path)
        .then((d) {
      customIcon.value = d;
    });
  }

  getDistance(LatLng start, LatLng end) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${start.latitude},${start.longitude}&destinations=${end.latitude},${end.longitude}&key=AIzaSyCm3u1m0jcc32T6IYo_Sgv1ynont7ienWo"));
    return jsonDecode(response.body);
  }

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  getAutoComplete(String query) async {
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json",
        {"input": query, "key": 'AIzaSyCm3u1m0jcc32T6IYo_Sgv1ynont7ienWo'});

    String? responce = await fetchUrl(uri);

    if (responce != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(responce);
      if (result.predictions != null) {
        placePredictions.assignAll(result.predictions!);
      }
    }
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
