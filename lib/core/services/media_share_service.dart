import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MediaShareService {
  static Future<void> shareImages(
    List<String> imagePaths, {
    String? text,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final files = <XFile>[];

    for (final imagePath in imagePaths) {
      final byteData = await rootBundle.load(imagePath);
      final file = File('${tempDir.path}/${imagePath.replaceAll('/', '_')}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      files.add(XFile(file.path));
    }

    await Share.shareXFiles(files, text: text);
  }
}
