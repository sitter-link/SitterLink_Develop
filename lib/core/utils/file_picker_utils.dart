import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {
  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["pdf"],
    );
    if (result?.files.isNotEmpty ?? false) {
      return File(result!.files.first.path!);
    } else {
      return null;
    }
  }
}

extension FileExtension on File {
  String get fileName {
    return path.split("/").last;
  }
}
