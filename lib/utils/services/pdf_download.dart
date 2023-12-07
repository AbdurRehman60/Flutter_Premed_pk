import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class PdfDownloader {
  final Dio _dio = Dio();

  Future<void> downloadAndSavePDF(String pdfUrl, String fileName) async {
    try {
      final response = await _dio.get(pdfUrl,
          options: Options(responseType: ResponseType.bytes));
      print(response);
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/$fileName.pdf';

      File file = File(filePath);
      await file.writeAsBytes(response.data as List<int>);

      // Now, 'file' contains the downloaded PDF.
      print('PDF downloaded to: $filePath');
    } catch (e) {
      print('Failed to download PDF: $e');
      // Handle the error as needed
    }
  }
}
