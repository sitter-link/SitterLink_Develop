import 'package:flutter/services.dart';

class TextUtils {
  static bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static List<TextInputFormatter> get textOnlyFormater =>
      [FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'), allow: true)];

  static List<TextInputFormatter> get numberOnlyFormater =>
      [FilteringTextInputFormatter.digitsOnly];

  static List<TextInputFormatter> get decimalInputFormater =>
      [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))];
}

extension Capitalize on String {
  String capitalize({bool allWords = true}) {
    if (isEmpty) {
      return this;
    }
    if (allWords) {
      final List<String> words = split(' ');
      final List<String> capitalized = <String>[];
      for (var w in words) {
        capitalized.add(w.capitalize(allWords: false));
      }
      return capitalized.join(' ');
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }
}

