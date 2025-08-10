
import 'package:image_picker/image_picker.dart';

class ImageRepository{

  final _picked = ImagePicker();

  Future<XFile?>cameraimage()async{
    final XFile? imagepath = await _picked.pickImage(source: ImageSource.camera,imageQuality: 100);
    return imagepath;
  }

  Future<XFile?>galleryimage()async{
    final XFile? imagepath = await _picked.pickImage(source: ImageSource.gallery,imageQuality: 100);
    return imagepath;
  }

}