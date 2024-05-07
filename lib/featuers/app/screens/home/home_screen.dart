import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/app/controllers/card_controller.dart';
import 'package:smart_car_park/featuers/app/controllers/park_controller.dart';
import 'package:smart_car_park/featuers/app/screens/home/map/google_map.dart';
import 'package:smart_car_park/featuers/app/screens/home/widgets/location_list_tile.dart';
import 'package:smart_car_park/featuers/personalization/controllers/user_controller.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(CardController());
    final controller = ParkController.instance;
    final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: CustomDrawerPrimary(
        sH: sH,
      ),
      appBar: AppBar(),
      body: Stack(
        children: [
          const GoogleMapWidget(),
          Positioned(
            top: sH * 0.1,
            left: sW * 0.15,
            child: SizedBox(
              width: 300,
              child: CustomInputField(
                onSubmit: (value) {
                  controller.getAutoComplete(value ?? 'Iraq');
                  return null;
                },
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                obscureText: false,
              ),
            ),
          ),
          Positioned(
            height: 400,
            width: 300,
            top: sH * 0.2,
            left: sW * 0.15,
            child: Obx(
              () => controller.placePredictions.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 0),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: controller.placePredictions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: LocationListTile(
                                    location: controller.placePredictions[index].description!,
                                    press: () {}));
                          },
                        ),
                      ),
                    )
                  : Container(),
            ),
          )
        ],
      ),
    );
  }
}
