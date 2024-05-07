import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_car_park/featuers/app/controllers/park_controller.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/featuers/app/screens/home/home_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:smart_car_park/featuers/app/screens/payment/payment_screen.dart';
import 'package:smart_car_park/featuers/personalization/screens/profile/profile_screen.dart';
import 'package:smart_car_park/featuers/personalization/screens/settings/settings.dart';
import 'package:smart_car_park/utils/helpers/helper_functions.dart';

class NavigationRouterScreen extends StatelessWidget {
  const NavigationRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ParkController());
    RxBool isLoading = false.obs;

    final controller = Get.put(NavigationRouterController());
    final parkController = ParkController.instance;
    final autoSizeGroup = AutoSizeGroup();

    final iconList = <IconData>[
      Icons.house_outlined,
      Icons.payment,
      Icons.person,
      Icons.settings,
    ];
    final labelList = <String>[
      "Home",
      "Payment",
      "Profile",
      "Settings",
    ];

    return Scaffold(
      body: Obx(() => controller.screens[controller.getIndex()]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Icon(
          Icons.switch_access_shortcut_add_outlined,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () async {
          if (controller.getIndex() != 0) {
            await controller.setIndex(0);
          }
          if (parkController.currentLocation != null) {
            RxList<double> allDistances = <double>[].obs;

            allDistances.assignAll(parkController.allParks.map((element) {
              final ParkModel park = element;
              final LatLng latLng = park.getLatLong;
              double distance = Geolocator.distanceBetween(
                parkController.currentLocation!.latitude,
                parkController.currentLocation!.longitude,
                latLng.latitude,
                latLng.longitude,
              );
              return distance;
            }).toList());

            isLoading.value = false;
            (double, int) scloseLDistance = parkController.findSmallest(allDistances);

            ParkModel recommened = parkController.allParks[scloseLDistance.$2];

            LatLng closeLocation = recommened.getLatLong;
            parkController.mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              closeLocation, // New camera position
              18, // New zoom level
            ));

            KHelperFunctions.showSnackBar("Recommened park: ${recommened.name}");
          } else {
            showModalBottomSheet(
                constraints: const BoxConstraints(maxHeight: 220),
                shape: const RoundedRectangleBorder(),
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  return Column(children: [
                    ListTile(
                      shape: const RoundedRectangleBorder(),
                      onTap: () {},
                      title: const Center(child: Text("Wait Unitl Locatin Loads")),
                    ),
                  ]);
                });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.black : Colors.black26;
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconList[index],
                  size: 24,
                  color: color,
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    labelList[index],
                    maxLines: 1,
                    style: TextStyle(
                      color: color,
                      fontFamily: "Oxygen",
                    ),
                    group: autoSizeGroup,
                  ),
                )
              ],
            );
          },
          backgroundColor: Colors.white70,
          activeIndex: controller.getIndex(),
          splashRadius: 0,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.center,
          onTap: (index) => controller.setIndex(index),
          shadow: const BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 12,
            spreadRadius: 0.5,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }
}

class NavigationRouterController extends GetxController {
  static NavigationRouterController get instance => Get.find();
  final _selectedIndex = 0.obs;

  getIndex() => _selectedIndex.value;
  setIndex(index) => _selectedIndex.value = index;
  final screens = [
    const HomeScreen(),
    const PaymentScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];
}
