import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';

class SearchtextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSearchPressed;
  final String hintText;
  final bool isFilled;

  const SearchtextField({
    super.key,
    required this.controller,
    this.onSearchPressed,
    required this.hintText,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 1.1,
        color: CustomTheme.textColor,
      ),
      controller: controller,
      cursorColor: CustomTheme.primaryColor,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onEditingComplete: onSearchPressed,
      onTapOutside: (event) {
        onSearchPressed?.call();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.backgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.backgroundColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.backgroundColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: CustomTheme.backgroundColor),
        ),
        fillColor: isFilled
            ? CustomTheme.grey.shade100.withOpacity(0.7)
            : Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        hintText: hintText,
        prefixIcon: Icon(
          CupertinoIcons.search,
          size: 22,
          color: CustomTheme.grey,
        ),
        hintStyle: TextStyle(
          color: CustomTheme.grey,
          fontSize: 15,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
