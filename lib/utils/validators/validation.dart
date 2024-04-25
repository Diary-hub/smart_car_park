class KValidator {
  static String? validateField(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName Requierd';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email Requierd';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Email Invalid';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password Requierd';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'More Than 6 Charecters';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'At Least Pne Capital';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'At Leaast One Number';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'At Least a Speacel Charecter';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone Requierd';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{11}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Must Be 11 Digits';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
