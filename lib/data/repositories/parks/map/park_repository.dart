import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_car_park/featuers/app/models/park_model.dart';
import 'package:smart_car_park/utils/exception/format_exceptions.dart';
import 'package:smart_car_park/utils/exception/platform_exceptions.dart';
import 'package:smart_car_park/utils/exception/firebase_exceptions.dart';

class ParkRepository extends GetxController {
  static ParkRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

// Get User Credit Cards
  Future<List<ParkModel>> getParksLocation() async {
    try {
      final snapshot = await _db.collection('Parks').get();

      final parks = snapshot.docs.map((document) {
        return ParkModel.fromSnapshot(document);
      }).toList();

      // Convert query snapshot to a list of parks datas
      return parks;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
