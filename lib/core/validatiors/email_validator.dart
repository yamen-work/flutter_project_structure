import 'package:email_validator/email_validator.dart';

String? validateEmail(String? value) {
  // Trim spaces and treat null/empty as invalid
  if (value == null || (value = value.trim()).isEmpty) {
    return "Enter An Email";
  }

  if (!EmailValidator.validate(value)) {
    return "Enter A Valid Email";
  }

  return null;
}