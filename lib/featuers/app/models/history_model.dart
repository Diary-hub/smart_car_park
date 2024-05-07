import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  HistoryModel({
    required this.location,
    required this.slot,
    required this.price,
    required this.userID,
    required this.date,
    this.id,
  });

  final String? id;
  final String location;
  final String slot;
  final String price;
  final String userID;
  final String date;

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'Location': location,
      'Slot': slot,
      'Price': price,
      'Date': date,
      'userID': userID,
    };
  }

  static HistoryModel empty() => HistoryModel(
        id: '',
        location: '',
        slot: '',
        price: '',
        userID: '',
        date: '',
      );

  // Create a UserModel instance from a Map
  factory HistoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return HistoryModel(
        id: document.id,
        location: data['Location'] ?? '',
        slot: data['Slot'] ?? '',
        price: data['Price'] ?? '',
        userID: data['userID'] ?? '',
        date: data['Date'] ?? '',
      );
    } else {
      return HistoryModel.empty();
    }
  }
}
