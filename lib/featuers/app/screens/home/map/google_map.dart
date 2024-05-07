import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/featuers/app/controllers/park_controller.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/featuers/app/screens/park_detail/park_detail.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final parkController = ParkController.instance;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await parkController.locationControler.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await parkController.locationControler.requestService();
    } else {
      return;
    }

    permissionGranted = await parkController.locationControler.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await parkController.locationControler.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        return;
      }
    }

    parkController.locationControler.onLocationChanged.listen((LocationData current) {
      if (current.latitude != null && current.longitude != null) {
        setState(() {
          parkController.currentLocation = LatLng(current.latitude!, current.longitude!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    return parkController.isLoading.value == true || parkController.currentLocation == null
        ? const Center(child: CircularProgressIndicator())
        : Obx(() {
            return GoogleMap(
              onTap: (argument) {
                KDeviceUtils.hideKeyboard(context);
                parkController.getAutoComplete('');
              },
              onMapCreated: (GoogleMapController controller) {
                parkController.mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: parkController.currentLocation!,
                zoom: 17,
              ),
              markers: parkController.allParks.map((element) {
                final ParkModel park = element;
                final LatLng latLng = park.getLatLong; // Capture element locally

                return Marker(
                  markerId: MarkerId(park.name),
                  position: latLng,
                  infoWindow: InfoWindow(title: park.name),
                  icon: parkController.customIcon.value,
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        showDragHandle: false,
                        constraints: BoxConstraints(maxHeight: sH * 0.6),
                        shape: const RoundedRectangleBorder(),
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context) {
                          RxBool loading = true.obs;
                          var datas = parkController.getDistance(
                              parkController.currentLocation!, park.getLatLong);
                          datas.then((value) {
                            datas = value;
                            datas = datas["rows"][0]["elements"][0]["duration"]["text"];
                            loading.value = false;
                          });

                          return Obx(
                            () => Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30)),
                                    width: sW * 0.9,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  AutoSizeText(
                                                    "${park.price}\nIQD",
                                                    style: const TextStyle(
                                                        fontSize: 20, fontWeight: FontWeight.w900),
                                                  ),
                                                  const AutoSizeText(
                                                    "/Hr",
                                                    style: TextStyle(fontSize: 20),
                                                  ),
                                                ],
                                              ),
                                              AutoSizeText(
                                                park.name,
                                                style: const TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          loading.value
                                              ? const CircularProgressIndicator()
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(horizontal: 10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const AutoSizeText(
                                                            "Number of Slots:",
                                                            style: TextStyle(fontSize: 18),
                                                          ),
                                                          SizedBox(width: sW * 0.1),
                                                          AutoSizeText(
                                                            park.slots,
                                                            style: const TextStyle(fontSize: 18),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const AutoSizeText(
                                                            "Distance By Car:",
                                                            style: TextStyle(fontSize: 18),
                                                          ),
                                                          SizedBox(width: sW * 0.1),
                                                          AutoSizeText(
                                                            "$datas",
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: FontWeight.w100,
                                                                fontFamily: 'Oxygen'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SimpleButton(
                                    onPressed: () {
                                      Get.to(ParkDetailsScreen(
                                        park: park,
                                      ));
                                    },
                                    text: "View Park Slots",
                                    width: 0.9,
                                    style: const TextStyle(color: Colors.white, fontSize: 30),
                                    backgroundColor: Colors.grey[850],
                                  ),
                                  const Row(),
                                ]),
                          );
                        });
                  },
                );
              }).toSet(),
            );
          });
  }
}
