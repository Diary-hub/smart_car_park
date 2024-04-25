import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_car_park/featuers/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:smart_car_park/featuers/authentication/screens/onboarding/widgets/onboarding_Page.dart';
import 'package:smart_car_park/featuers/authentication/screens/onboarding/widgets/onboarding_dotnavigation.dart';
import 'package:smart_car_park/featuers/authentication/screens/onboarding/widgets/onboarding_nextbutton.dart';
import 'package:smart_car_park/featuers/authentication/screens/onboarding/widgets/onboarding_skipbutton.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageInicator,
            children: const [
              OnBoardingPage(
                image:
                    "https://media.istockphoto.com/id/1268257891/vector/blue-square-parking-sign-with-a-white-capital-letter-p.jpg?s=612x612&w=0&k=20&c=B9vXVYqPizyhwECC8QzKcOsd4e2Y6tfV911rr62CbrE=",
                subTitile: "Find Parking Spots Near You",
                title: "SmartPark System",
              ),
              OnBoardingPage(
                image: 'https://miro.medium.com/v2/resize:fit:300/1*R4c8lHBHuH5qyqOtZb3h-w.png',
                subTitile: "Real-Time Informations",
                title: "Firebase Featuers",
              ),
              OnBoardingPage(
                image: "https://cdn-icons-png.flaticon.com/512/5582/5582334.png",
                subTitile: "We Will Save Your Records",
                title: "Keep Track Of History",
              ),
            ],
          ),
          const OnBoardingSkipButton(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
