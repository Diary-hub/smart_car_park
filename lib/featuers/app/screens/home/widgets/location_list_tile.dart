import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({
    super.key,
    required this.location,
    required this.press,
  });

  final String location;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration:
              BoxDecoration(color: Colors.deepPurple[50], borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            onTap: press,
            horizontalTitleGap: 0,
            leading: const Icon(
              Icons.location_on_outlined,
              color: Colors.amber,
            ),
            title: Text(
              location,
              style: const TextStyle(color: Colors.black),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Divider(
          height: 2,
          thickness: 2,
          color: Colors.black12,
        ),
      ],
    );
  }
}
