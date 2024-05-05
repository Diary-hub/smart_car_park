import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkModel {
  ParkModel({
    required this.name,
    required this.price,
    required this.latitude,
    required this.longitude,
    this.id,
  });

  final String? id;
  final String name;
  final String price;
  final String latitude;
  final String longitude;

  LatLng get getLatLong => LatLng(double.parse(longitude), double.parse(latitude));

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Price': price,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }

  static ParkModel empty() => ParkModel(
        id: '',
        name: '',
        price: '',
        latitude: '',
        longitude: '',
      );

  // Create a UserModel instance from a Map
  factory ParkModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ParkModel(
        id: document.id,
        name: data['Name'] ?? '',
        price: data['Price'] ?? '',
        latitude: data['Latitude'] ?? '',
        longitude: data['Longitude'] ?? '',
      );
    } else {
      return ParkModel.empty();
    }
  }
}
