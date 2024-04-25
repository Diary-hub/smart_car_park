import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:smart_car_park/featuers/app/screens/home/home_screen.dart';
import 'package:smart_car_park/featuers/app/screens/park_detail/park_detail.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:smart_car_park/featuers/personalization/screens/settings/settings.dart';

class NavigationRouterScreen extends StatelessWidget {
  const NavigationRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationRouterController());
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
        onPressed: () {
          showModalBottomSheet(
              constraints: const BoxConstraints(maxHeight: 120),
              context: context,
              builder: (context) {
                return Column(children: [
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onTap: () {},
                    title: const Text("AI Scanner"),
                  ),
                  ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => const Scaffold()));
                    },
                    title: const Text("QR Code Scanner"),
                  ),
                ]);
              });
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
  final _selectedIndex = 0.obs;

  getIndex() => _selectedIndex.value;
  setIndex(index) => _selectedIndex.value = index;
  final screens = [
    const HomeScreen(),
    const ParkDetailsScreen(),
    const HomeScreen(),
    const SettingScreen(),
  ];
}
