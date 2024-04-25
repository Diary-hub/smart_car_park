import 'package:flutter/material.dart';
import 'package:smart_car_park/common/widgets/custom_input_feild.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(),
          SizedBox(
            width: 300,
            child: CustomInputField(
              labelText: "Search",
              prefixIcon: const Icon(Icons.search),
              obscureText: false,
            ),
          ),
          const Row(),
        ],
      ),
    );
  }
}
