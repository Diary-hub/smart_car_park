import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/utils/constants/colors.dart';
import 'package:smart_car_park/common/widgets/simple_button.dart';
import 'package:smart_car_park/common/widgets/custom_menu_tile.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_header_primary.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';

class CustomDrawerPrimary extends StatelessWidget {
  const CustomDrawerPrimary({
    super.key,
    required this.sH,
  });

  final double sH;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      backgroundColor: KColors.white,
      child: ListView(
        children: [
          SizedBox(
            height: sH * 0.37,
            child: const CustomDrawerHeaderPrimary(),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Iconsax.card5,
            title: "Payment Method",
            subTitle: "Check your payments",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Icons.history,
            title: "Parking History",
            subTitle: "Check your history",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Icons.check_circle,
            title: "Promotion Code",
            subTitle: "Get CashBacks",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Icons.info,
            title: "How it Works",
            subTitle: "Use Cases",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Icons.help,
            title: "Support",
            subTitle: "Get help",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          ProfileMenuTile(
            onTap: () {},
            icon: Icons.settings,
            title: "Settings",
            subTitle: "Go to Settings",
            trailing: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleButton(
                  backgroundColor: KColors.error,
                  width: 0.4,
                  height: 0.06,
                  onPressed: () => AuthenticationRepository.instance.logout(),
                  text: "Logout",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ],
      ),
    );
  }
}
