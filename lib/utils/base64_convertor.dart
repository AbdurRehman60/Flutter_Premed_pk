import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Future<String> imageToBase64(File imageFile) async {
  try {
    final Uint8List uint8List = await imageFile.readAsBytes();
    final base64String = base64Encode(uint8List);
    return base64String;
  } catch (e) {
    return e.toString();
  }
}

Future<String> imageToDataUri(File imageFile, String mimeType) async {
  try {
    final Uint8List uint8List = await imageFile.readAsBytes();
    final base64String = base64Encode(uint8List);
    final dataUri = 'data:$mimeType;base64,$base64String';
    return dataUri;
  } catch (e) {
    return e.toString();
  }
}
