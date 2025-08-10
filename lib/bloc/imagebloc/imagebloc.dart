


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iot/repository/imagerepository/imagerepository.dart';

part 'imagestates.dart';
part 'imageevent.dart';


class ImageBloc extends Bloc<ImageEvent,ImageStates>{
  final ImageRepository imageRepository;
  ImageBloc(this.imageRepository):super(ImageStates()){
    on<GalleryCapture>(_gallery);
    on<CameraCapture>(_camera);
    on<DeleteImage>(_delete);
  }

  _gallery(GalleryCapture event,Emitter<ImageStates>emit)async{
    final imagepath = await imageRepository.galleryimage();
    emit(state.copyWith(imagepath: imagepath));
  }

  _camera(CameraCapture event,Emitter<ImageStates>emit)async{
    final image = await imageRepository.cameraimage();
    emit(state.copyWith(imagepath: image));
  }

  _delete(DeleteImage event,Emitter<ImageStates>emit){
    emit(state.copyWith(imagepath: null));
  }

}