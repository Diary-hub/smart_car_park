import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/app/controllers/card_controller.dart';
import 'package:smart_car_park/featuers/app/controllers/park_controller.dart';
import 'package:smart_car_park/featuers/app/screens/home/map/google_map.dart';
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
                labelText: "Search",
                prefixIcon: const Icon(Icons.search),
                obscureText: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
