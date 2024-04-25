import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.profilePicture,
    required this.dateOfBirth,
    required this.dateOfAccount,
    required this.gender,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  String profilePicture;
  final String dateOfBirth;
  final String dateOfAccount;
  final String gender;

  String get getFirstName => firstName;
  String get getlastName => lastName;
  String get getFulltName => "$firstName $lastName";

  String get getPhoneNumber => KFormatter.formatPhoneNumber(phoneNumber);

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'ProfilePicture': profilePicture,
      'DateOfBirth': dateOfBirth,
      'DateOfAccount': dateOfAccount,
      'Gender': gender,
    };
  }

  static UserModel empty() => UserModel(
      dateOfAccount: '',
      dateOfBirth: '',
      gender: '',
      id: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      email: '',
      profilePicture: '');

  // Create a UserModel instance from a Map
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        email: data['Email'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        dateOfBirth: data['DateOfBirth'] ?? '',
        dateOfAccount: data['DateOfAccount'] ?? '',
        gender: data['Gender'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
