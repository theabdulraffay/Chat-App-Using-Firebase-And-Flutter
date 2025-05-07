import 'package:file_picker/file_picker.dart';

class MediaService {
  // This class is responsible for handling media-related operations
  // such as uploading, downloading, and managing media files.
  // Add your methods and properties here.
  MediaService();

  Future<PlatformFile?> pickImageFromLibrary() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      return result.files.first;
    }
    return null;
  }
}
