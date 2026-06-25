import 'package:intl/intl.dart';

/// to add a comma after 3 digits so 1000000 becomes 1,000,000
String formatWithCommas(String value) {
  final number = num.tryParse(value.replaceAll(RegExp(r'[^\d.-]'), ''));
  if (number == null) return value;

  final formatter = NumberFormat.decimalPattern();
  return formatter.format(number);
}
