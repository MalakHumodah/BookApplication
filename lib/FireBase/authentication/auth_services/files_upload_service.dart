import 'dart:io';

class FilesUploadService {
  late Reference firebaseStorageRef;

  Future<String> fileUpload(File file,String valueName) async {
    String result = '';
    firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('$valueName/${path.basename(file.path)}');
    await firebaseStorageRef.putFile(file).whenComplete(() async {
      await firebaseStorageRef.getDownloadURL().then((value) {
        result = value;
      });
    });
    return result;
  }
}