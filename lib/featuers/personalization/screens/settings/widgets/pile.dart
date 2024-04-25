import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Pile extends StatelessWidget {
  final Function() onTap;
  final IconData iconData;
  final String title;

  const Pile({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
            alignment: Alignment.center,
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white, // inner color
            ),
            // 2 Slots Pages
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: Colors.deepPurpleAccent,
                  size: 40,
                ),
                AutoSizeText(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                )
              ],
            )),
      ),
    );
  }
}
