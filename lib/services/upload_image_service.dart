import 'dart:developer';

import 'package:dio/dio.dart';

class UploadImageService {
  // This class is responsible for uploading images to a server or cloud storage.
  // It will handle the image upload process and return the result of the upload.

  Future<String?> uploadImage(String imagePath) async {
    // Simulate an image upload process
    final response = await Dio().post(
      'https://api.cloudinary.com/v1_1/dft4vja97/upload',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
        'upload_preset': 'YOUR_PRESET_NAME',
      }),
      options: Options(headers: {'X-Requested-With': 'XMLHttpRequest'}),
    );

    if (response.statusCode == 200) {
      // Upload successful
      final imageUrl = response.data['url'];
      return imageUrl;
    } else {
      // Handle upload error
      log('Error uploading image: ${response.data['error']['message']}');
    }
    return null;
  }
}
