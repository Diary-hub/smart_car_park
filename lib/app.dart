import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/bindings/general_bindings.dart';

import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    KDeviceUtils.hideStatusBarFully();
    return GetMaterialApp(
        initialBinding: GeneralBindings(),
        debugShowCheckedModeBanner: false,
        theme: KAppTheme.darkTheme,
        darkTheme: KAppTheme.darkTheme,
        home: const Scaffold());
  }
}
