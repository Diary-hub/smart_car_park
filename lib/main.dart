import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_car_park/app.dart';
import 'package:flutter/material.dart';
import 'package:smart_car_park/data/repositories/authentication/authentication_repository.dart';
import 'package:smart_car_park/firebase_options.dart';

Future<void> main() async {
  // Widget Bindings
  WidgetsFlutterBinding.ensureInitialized;

  // Localstorage init
  GetStorage.init();

  // awwiat native splash

  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // init auth
  Get.put(AuthenticationRepository());

  runApp(
    const App(), // Wrap your app
  );
}
