import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_car_park/featuers/app/models/history_model.dart';
import 'package:smart_car_park/utils/exception/format_exceptions.dart';
import 'package:smart_car_park/utils/exception/platform_exceptions.dart';
import 'package:smart_car_park/utils/exception/firebase_exceptions.dart';

class HistoryRepository extends GetxController {
  static HistoryRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveParkHistory(HistoryModel history) async {
    try {
      await _db.collection('History').add(history.toJson());
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

  Future<void> deleteParkHistory(String id) async {
    try {
      await _db.collection('History').doc(id).delete();
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

  // Get User Credit Cards
  Future<List<HistoryModel?>> getHistory() async {
    try {
      final snapshot = await _db.collection('History').get();

      final history = snapshot.docs.map((document) {
        return HistoryModel.fromSnapshot(document);
      }).toList();

      // Convert query snapshot to a list of parks datas
      return history;
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
