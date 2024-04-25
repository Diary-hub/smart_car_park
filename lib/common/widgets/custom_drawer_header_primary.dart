import 'package:flutter/material.dart';

class CustomDrawerHeaderPrimary extends StatelessWidget {
  const CustomDrawerHeaderPrimary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi8g14wE74YAOQsCVjWVwd_CuBlCa6-pK2ft1sLTngMgQWaHKOCKaoSS-cmlrmEEmiCRsM7ZhZ2-t98IqnJUAIB4dDMe_loFHmc9b7brxHaWJ93nwSglDQP-UF16ISzVQsfu9MAgQ3Bdvs/s1600/User_man_male_profile_account_person_people.pngs",
        ),
      ),
      currentAccountPictureSize: Size.fromRadius(80),
      accountName: Text("Diary Tariq Ibrahem"),
      accountEmail: Text("iinoob4ever@gmail.com"),
    );
  }
}
