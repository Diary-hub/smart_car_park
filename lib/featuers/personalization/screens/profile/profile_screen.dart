import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/common/widgets/custom_drawer_primary.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';
import 'package:smart_car_park/common/widgets/shimmer_effect.dart';
import 'package:smart_car_park/common/widgets/see_more_section.dart';
import 'package:smart_car_park/featuers/personalization/controllers/user_controller.dart';
import 'package:smart_car_park/featuers/personalization/screens/profile/widgets/profile_tile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final sH = KDeviceUtils.getScreenHeight();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        drawer: CustomDrawerPrimary(
          sH: sH,
        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.defaultSpace),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Obx(() {
                        final userImage = controller.user.value.profilePicture;
                        final image = userImage.isNotEmpty
                            ? userImage
                            : "https://wallpapers.com/images/hd/cool-profile-picture-87h46gcobjl5e4xu.jpg";

                        return controller.imageUploading.value
                            ? const ShimmerEffect(width: 55, height: 55)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: image,
                                  width: 80,
                                  height: 80,
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      const ShimmerEffect(width: 55, height: 55),
                                ),
                              );
                      }),
                      TextButton(
                        onPressed: () => controller.uploadUserImage(),
                        child: Text(
                          "Change Profile Picture",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: KColors.buttonPrimary),
                        ),
                      )
                    ],
                  ),
                ),
                // API
                // AIzaSyCDo3C0ad7f8r6cENz2ZZBfCwcAWHivLtI
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                const Divider(),
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                SeeMoreSection(
                  title: "Personal Information",
                  titleStyle:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(color: KColors.black),
                  subTitle: "",
                  showButton: false,
                ),
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                ProfileTileInfo(
                  title: "Name",
                  value: controller.user.value.getFulltName,
                ),
                const SizedBox(height: KSizes.spaceBetweenItems),
                ProfileTileInfo(
                  title: "Mobile",
                  value: KFormatter.formatPhoneNumber(controller.user.value.phoneNumber),
                ),
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                const Divider(),
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                SeeMoreSection(
                  title: "Account Information",
                  titleStyle:
                      Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                  subTitle: "",
                  showButton: false,
                ),
                ProfileTileInfo(
                  title: "UID",
                  value: controller.user.value.id,
                  icon: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_all)),
                ),
                const SizedBox(height: KSizes.spaceBetweenItems),
                ProfileTileInfo(
                  title: "Email",
                  value: controller.user.value.email,
                ),
                const SizedBox(height: KSizes.spaceBetweenItems),
                const SizedBox(height: KSizes.spaceBetweenItems),
                ProfileTileInfo(
                  title: "Account Date",
                  value: controller.user.value.dateOfAccount,
                ),
                const SizedBox(height: KSizes.spaceBetweenItems / 2),
                const Divider(),
                const SizedBox(height: KSizes.spaceBetweenItems),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
