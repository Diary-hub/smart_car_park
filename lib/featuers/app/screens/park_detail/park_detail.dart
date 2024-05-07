import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/app/controllers/history_controller.dart';
import 'package:smart_car_park/featuers/app/controllers/slots_controller.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/featuers/app/screens/park_detail/widgets/slots.dart';

class ParkDetailsScreen extends StatelessWidget {
  final ParkModel park;
  const ParkDetailsScreen({super.key, required this.park});

  @override
  Widget build(BuildContext context) {
    final autoSizeGroup = AutoSizeGroup();
    // final sW = KDeviceUtils.getScreenWidht(context);
    final sH = KDeviceUtils.getScreenHeight();
    final SlotsController slotsController = Get.put(SlotsController());

    return Scaffold(
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
                      park.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      group: autoSizeGroup,
                    ),
                    AutoSizeText(
                      minFontSize: 10,
                      maxFontSize: 24,
                      "${park.price} IQD/Hr",
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
              "${park.slots}/10 slots avalabile",
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
                            const Text(
                              "A \n Slots 1-4",
                              textAlign: TextAlign.center,
                            ),
                            Obx(
                              () => Slots(
                                firstFree: slotsController.firstAFree.value,
                                secondFree: slotsController.secondAFree.value,
                              ),
                            ),
                            SizedBox(height: sH * 0.02),
                            Obx(
                              () => Slots(
                                firstFree: slotsController.thirdAFree.value,
                                secondFree: slotsController.fourthAFree.value,
                              ),
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
                            const Text(
                              "B \n Slots 1-4",
                              textAlign: TextAlign.center,
                            ),
                            Obx(
                              () => Slots(
                                firstFree: slotsController.firstBFree.value,
                                secondFree: slotsController.secondBFree.value,
                              ),
                            ),
                            SizedBox(height: sH * 0.02),
                            Obx(
                              () => Slots(
                                firstFree: slotsController.thirdBFree.value,
                                secondFree: slotsController.fourthBFree.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),

            SizedBox(height: sH * 0.02),
            SimpleButton(
              onPressed: () {
                final controller = HistoryController.instance;

                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  builder: (context) {
                    return Obx(
                      () => ListView(
                        children: [
                          ListTile(
                            enabled: !slotsController.firstBFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "B1", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: B1",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.secondBFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "B2", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: B2",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.thirdBFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "B3", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: B3",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.fourthBFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "B4", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: B4",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.firstAFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "A1", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: A1",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.secondAFree.value,
                            onTap: () {
                              controller.saveHistory(
                                  park.name, "A2", park.price, DateTime.now().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: A2",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.thirdAFree.value,
                            onTap: () {
                              controller.saveHistory(park.name, "A3", park.price,
                                  DateTime.now().toString().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: A3",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                          ListTile(
                            enabled: !slotsController.fourthAFree.value,
                            onTap: () {
                              controller.saveHistory(park.name, "A4", park.price,
                                  DateTime.now().toString().toString());
                            },
                            leading: const Icon(
                              Icons.share_location,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            title: const Text(
                              "Slot: A4",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Oxygen",
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              width: 0.80,
              text: "Reserve a Slot",
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
