// ignore_for_file: empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SlotsController extends GetxController {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  RxBool firstFree = true.obs;
  RxBool secondFree = true.obs;
  RxBool thirdtFree = true.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToDatabase();
  }

  void _listenToDatabase() {
    try {
      _databaseReference.child('a4').onValue.listen((event) {
        final bool value = event.snapshot.value as bool;
        firstFree.value = value;
        secondFree.value = value;
        thirdtFree.value = value;
      });
    } catch (e) {}
  }
}
