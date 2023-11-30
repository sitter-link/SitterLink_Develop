import 'package:easy_localization/easy_localization.dart';

extension NumberExtension on num {
  String format() {
    final formattedAmount = NumberFormat.currency(
      symbol: "",
      customPattern: '\u00A4\u00A0##,##,##0.00',
    ).format(this);

    if (formattedAmount.endsWith('.00')) {
      return formattedAmount.substring(0, formattedAmount.length - 3);
    }
    return formattedAmount.trim();
  }
}
