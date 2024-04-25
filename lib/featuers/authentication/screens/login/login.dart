import 'package:flutter/material.dart';
import 'package:smart_car_park/featuers/authentication/screens/login/widgets/login_form.dart';
import 'package:smart_car_park/utils/constants/sizes.dart';
import 'package:smart_car_park/common/styles/spacing_padding_sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: KSpacingPaddingSizes.paddingWithAppBarHeight,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 300,
                      image: NetworkImage(
                          "https://freeiconshop.com/wp-content/uploads/edd/car-flat.png"),
                    ),
                  ],
                ),
                SizedBox(height: KSizes.defaultSpace),
                LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
