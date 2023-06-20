import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (EmailValidator.validate(value)) {
      return 'Invalid email';
    }
    return null;
  }
}
