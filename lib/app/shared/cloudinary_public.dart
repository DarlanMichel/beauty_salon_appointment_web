import 'package:cloudinary_public/cloudinary_public.dart';

class CustomCloudinary{
  static CloudinaryPublic getCloudinary(){
    return CloudinaryPublic('dx1tx3aso', 'iyrrvxvs', cache: false);
  }
}