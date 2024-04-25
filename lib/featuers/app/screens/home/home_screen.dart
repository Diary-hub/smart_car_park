import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    return Scaffold(
      drawer: CustomDrawerPrimary(
        sH: sH,
      ),
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          SizedBox(
            width: 300,
            child: CustomInputField(
              labelText: "Search",
              prefixIcon: const Icon(Icons.search),
              obscureText: false,
            ),
          ),
          const Row(),
        ],
      ),
    );
  }
}
