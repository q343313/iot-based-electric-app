



part of 'imagebloc.dart';

class ImageStates extends Equatable{

  final XFile? imagepath;
  ImageStates({this.imagepath});

  ImageStates copyWith({XFile?imagepath}){
    return ImageStates(
      imagepath: imagepath
    );
  }

  @override
  List<Object?>get props => [imagepath];
}