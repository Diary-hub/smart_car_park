// ignore_for_file: empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class SlotsController extends GetxController {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  RxBool firstBFree = true.obs;
  RxBool secondBFree = true.obs;
  RxBool thirdBFree = true.obs;
  RxBool fourthBFree = true.obs;
  RxBool firstAFree = true.obs;
  RxBool secondAFree = true.obs;
  RxBool thirdAFree = true.obs;
  RxBool fourthAFree = true.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToDatabase();
  }

  void _listenToDatabase() {
    try {
      _databaseReference.child('Slots/B4').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        fourthBFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/B3').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        thirdBFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/B2').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        secondBFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/B1').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        firstBFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/A4').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        fourthAFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/A3').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        thirdAFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/A2').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        secondAFree.value = value == 0 ? false : true;
      });
      _databaseReference.child('Slots/A1').onValue.listen((event) {
        final int value = event.snapshot.value as int;
        firstAFree.value = value == 0 ? false : true;
      });
    } catch (e) {}
  }
}
