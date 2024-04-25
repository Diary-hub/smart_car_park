import 'package:flutter/widgets.dart';
import 'package:smart_car_park/featuers/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smart_car_park/utils/constants/colors.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: KDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: KSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(activeDotColor: KColors.light, dotHeight: 6),
      ),
    );
  }
}
