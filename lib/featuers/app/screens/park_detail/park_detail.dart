import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:smart_car_park/featuers/app/controllers/slots_controller.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';
import 'package:smart_car_park/featuers/app/screens/park_detail/widgets/slots.dart';

class ParkDetailsScreen extends StatelessWidget {
  const ParkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    // final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    final SlotsController slotsController = Get.put(SlotsController());

    return Scaffold(
      drawer: CustomDrawerPrimary(
        sH: sH,
      ),
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(),
            SizedBox(height: sH * 0.05),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2), // outer shadow color
                      blurRadius: 10,
                      spreadRadius: 0.3,
                      offset: const Offset(1, 10)),
                ],
              ),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white, // inner color
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 30,
                      "Tuy Melik Car Park A",
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      group: autoSizeGroup,
                    ),
                    AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 24,
                      "500 IQD/Hr",
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      group: autoSizeGroup,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: sH * 0.05),
            AutoSizeText(
              "Select Preferred Spot",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: sH * 0.02),
            AutoSizeText(
              "5/10 slots avalabile",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            //Slots
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2), // outer shadow color
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(1, 10)),
                ],
              ),
              child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white, // inner color
                  ),
                  // 2 Slots Pages
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Obx(
                              () => Slots(
                                firstFree: slotsController.firstFree.value,
                                secondFree: slotsController.secondFree.value,
                                thirdtFree: slotsController.thirdtFree.value,
                              ),
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: false,
                              secondFree: true,
                              thirdtFree: false,
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: true,
                              secondFree: false,
                              thirdtFree: true,
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: false,
                              secondFree: false,
                              thirdtFree: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1, // Width of the divider
                        height: 220,
                        child: Container(
                          color: Colors.black, // Color of the divider
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Slots(
                              firstFree: true,
                              secondFree: false,
                              thirdtFree: false,
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: false,
                              secondFree: false,
                              thirdtFree: false,
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: false,
                              secondFree: true,
                              thirdtFree: false,
                            ),
                            SizedBox(height: sH * 0.02),
                            const Slots(
                              firstFree: false,
                              secondFree: true,
                              thirdtFree: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),

            SizedBox(height: sH * 0.02),
            SimpleButton(
              onPressed: () {},
              width: 0.80,
              text: "Back",
              backgroundColor: Colors.grey[850],
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Row(),
          ],
        ),
      ),
    );
  }
}
