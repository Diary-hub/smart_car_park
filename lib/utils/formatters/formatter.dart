import 'package:intl/intl.dart';

class KFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatCardNumber(String cardNumber) {
    if (cardNumber == '' || cardNumber.length > 16) {
      return '';
    }

    return '${cardNumber.substring(0, 4)} ${cardNumber.substring(4, 8)} ${cardNumber.substring(8, 12)} ${cardNumber.substring(12, 16)}';
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 11) {
      return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)}  ${phoneNumber.substring(7)}';
    }

    // Other Formats
    return phoneNumber;
  }
}
