import 'dart:io';
import 'dart:typed_data';

Future<Uint8List?> readImageFileBytes(String path) => File(path).readAsBytes();
