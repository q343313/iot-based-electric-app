


part of'imagebloc.dart';

abstract class ImageEvent extends Equatable{
  @override
  List<Object>get props => [];
}

class CameraCapture extends ImageEvent{}
class GalleryCapture extends ImageEvent{}
class DeleteImage extends ImageEvent{}
