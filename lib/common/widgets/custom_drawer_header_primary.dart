import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/personalization/controllers/user_controller.dart';

class CustomDrawerHeaderPrimary extends StatelessWidget {
  const CustomDrawerHeaderPrimary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(
      () => UserAccountsDrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
            controller.user.value.profilePicture,
          ),
        ),
        currentAccountPictureSize: const Size.fromRadius(80),
        accountName: Text(controller.user.value.getFulltName),
        accountEmail: Text(controller.user.value.email),
      ),
    );
  }
}
