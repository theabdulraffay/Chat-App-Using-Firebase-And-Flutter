part of '../home.dart';

class _Body extends StatefulWidget {
  _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final TextEditingController taskController = TextEditingController();
  XFile? imageFile;
  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseUsersServices().logoutUser();
              AppRoutes.signup.push(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child:
                  imageFile == null
                      ? Text('No image selected')
                      : Image.file(File(imageFile!.path)),
            ),
            ElevatedButton(
              onPressed: () async {
                final response = await Dio().post(
                  'https://api.cloudinary.com/v1_1/dft4vja97/upload',
                  data: FormData.fromMap({
                    'file': await MultipartFile.fromFile(
                      imageFile!.path,
                      filename: imageFile!.path.split('/').last,
                    ),
                    'upload_preset': 'YOUR_PRESET_NAME',
                  }),
                  options: Options(
                    headers: {'X-Requested-With': 'XMLHttpRequest'},
                  ),
                );

                if (response.statusCode == 200) {
                  // Upload successful
                  final imageUrl = response.data['url'];
                  print('Image uploaded successfully: $imageUrl');
                  // Use the image URL in your application
                } else {
                  // Handle upload error
                  print(
                    'Error uploading image: ${response.data['error']['message']}',
                  );
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imagePicker.pickImage(source: ImageSource.camera).then((value) {
            setState(() {
              imageFile = value;
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
