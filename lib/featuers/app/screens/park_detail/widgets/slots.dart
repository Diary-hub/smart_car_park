import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Slots extends StatelessWidget {
  final Widget? first;
  final Widget? second;
  final bool firstFree;
  final bool secondFree;

  const Slots({
    super.key,
    required this.firstFree,
    required this.secondFree,
    this.first,
    this.second,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          first ??
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.directions_car_filled,
                      color: firstFree ? Colors.green : Colors.red)),
          second ??
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.directions_car_filled,
                      color: secondFree ? Colors.green : Colors.red)),
        ],
      ),
    );
  }
}
