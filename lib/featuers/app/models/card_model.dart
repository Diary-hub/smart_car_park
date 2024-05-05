import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_car_park/utils/formatters/formatter.dart';

class CardModel {
  CardModel({
    required this.cardBrand,
    required this.cardCvv,
    required this.cardNameHolder,
    required this.cardNumber,
    required this.expireDate,
    this.id,
  });

  final String? id;
  final String cardNumber;
  final String expireDate;
  final String cardBrand;
  final String cardNameHolder;
  final String cardCvv;

  String get getCardNumber => KFormatter.formatCardNumber(cardNumber);

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'CardNumber': cardNumber,
      'ExpireDate': expireDate,
      'CardBrand': cardBrand,
      'CardNameHolder': cardNameHolder,
      'CardCvv': cardCvv,
    };
  }

  static CardModel empty() => CardModel(
        id: '',
        cardNumber: '',
        expireDate: '',
        cardBrand: '',
        cardNameHolder: '',
        cardCvv: '',
      );

  // Create a UserModel instance from a Map
  factory CardModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CardModel(
        id: document.id,
        cardNumber: data['CardNumber'] ?? '',
        expireDate: data['ExpireDate'] ?? '',
        cardBrand: data['CardBrand'] ?? '',
        cardNameHolder: data['CardNameHolder'] ?? '',
        cardCvv: data['CardCvv'] ?? '',
      );
    } else {
      return CardModel.empty();
    }
  }
}
