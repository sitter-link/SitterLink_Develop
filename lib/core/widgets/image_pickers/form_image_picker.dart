// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nanny_app/core/images/custom_network_image.dart';
import 'package:nanny_app/core/theme/custom_theme.dart';
import 'package:nanny_app/core/utils/image_picker_utils.dart';
import 'package:nanny_app/core/utils/size_utils.dart';
import 'package:nanny_app/core/widgets/image_pickers/image_picker_bottomsheet.dart';

class FormImagePicker extends StatefulWidget {
  final String label;
  final ValueChanged<File?>? onChanged;
  final File? initialFile;
  final String fieldName;
  final bool isRequired;
  final String imageUrl;
  const FormImagePicker({
    super.key,
    this.initialFile,
    this.imageUrl = "",
    required this.label,
    this.onChanged,
    required this.fieldName,
    this.isRequired = true,
  });

  @override
  State<FormImagePicker> createState() => _FormImagePickerState();
}

class _FormImagePickerState extends State<FormImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomTheme.horizontalPadding,
        vertical: 16,
      ),
      constraints: BoxConstraints(
        minHeight: 60.hp,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CustomTheme.grey.shade300,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: FormBuilderField<File>(
          name: widget.fieldName,
          validator: (value) {
            if (value != null || !widget.isRequired) {
              return null;
            } else {
              return "${widget.label} field cannot be empty";
            }
          },
          initialValue: widget.initialFile,
          builder: (FormFieldState<dynamic> field) {
            return InputDecorator(
              decoration: InputDecoration(
                errorText: field.errorText,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.375,
                          ),
                        ),
                        if (_pickedImage != null || widget.imageUrl.isNotEmpty)
                          SizedBox(height: 8.hp),
                        if (_pickedImage != null || widget.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: _pickedImage != null
                                ? Image.file(
                                    _pickedImage!,
                                    height: 68,
                                    width: 68,
                                    fit: BoxFit.cover,
                                  )
                                : CustomCachedNetworkImage(
                                    url: widget.imageUrl,
                                    height: 68,
                                    width: 68,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) {
                          return ImagePickerBottomSheet(
                            onGalleryPressed: () async {
                              final res = await ImagePickerUtils.getGallery();
                              if (res != null) {
                                setState(() {
                                  _pickedImage = res;
                                  field.didChange(res);
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(res);
                                  }
                                });
                              }
                              Navigator.pop(context);
                            },
                            onCameraPressed: () async {
                              final res = await ImagePickerUtils.getCamera();
                              if (res != null) {
                                setState(() {
                                  _pickedImage = res;
                                  field.didChange(res);
                                  if (widget.onChanged != null) {
                                    widget.onChanged!(res);
                                  }
                                });
                              }
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    child: Text(
                      switch (_pickedImage) {
                        null => "Add",
                        _ => "Edit",
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: CustomTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
