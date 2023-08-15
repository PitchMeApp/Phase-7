import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_pickers/image_pickers.dart';

class AddImageController extends GetxController {
  List listImagePaths = [];
  List ischackIndex = [
    {'check': false},
    {'check': false},
    {'check': false},
    {'check': false},
  ];
  //GalleryMode _galleryMode = GalleryMode.image;

  int count = 4;
  String filePath = "";
  File fileFullPath = File('');

  // Future<void> selectImages() async {
  //   try {
  //     _galleryMode = GalleryMode.image;
  //     listImagePaths = await ImagePickers.pickerPaths(
  //       galleryMode: _galleryMode,
  //       showGif: true,
  //       selectCount: 4,
  //       showCamera: true,
  //       cropConfig: CropConfig(enableCrop: true, height: 1, width: 1),
  //       compressSize: 500,
  //       uiConfig: UIConfig(
  //         uiThemeColor: DynamicColor.blue,
  //       ),
  //     );

  // if (_listImagePaths.length > 0) {
  //   _listImagePaths.forEach((media) {
  //     print(media.path.toString());
  //   });
  // }
  //     update();
  //   } on PlatformException {}
  // }

  Future<void> selectImage(int index) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      for (var i = 0; i < ischackIndex.length; i++) {
        if (index == i) {
          if (ischackIndex[i]['check'] != true) {
            ischackIndex[i]['check'] = true;
            listImagePaths.add(imageTemporary.path);
          } else {
            listImagePaths.remove(listImagePaths[i]);
            listImagePaths.add(imageTemporary.path);
          }
        }
      }

      update();
    } on PlatformException catch (e) {}
  }

  Future<void> getDocumnetFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowedExtensions: ['pdf', 'doc'], type: FileType.custom);

      if (result != null) {
        PlatformFile file = result.files.first;
        filePath = result.files.first.name.toString();
        fileFullPath = File(result.files.single.path!);
      } else {}
    } on PlatformException {}

    update();
  }
}
