import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/save_service_category_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/save_service_category/save_service_category_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'save_service_category_usecase_imp.g.dart';

@Injectable(singleton: false)
class SaveServiceCategoryUseCaseImp implements SaveServiceCategoryUseCase {
  final SaveServiceCategoryRepository _saveServiceCategoryRepository;
  SaveServiceCategoryUseCaseImp(this._saveServiceCategoryRepository);

  @override
  Future<Either<Exception, ServiceCategoryEntity>> call(
      {required String name, required String picture}) async {
    return await _saveServiceCategoryRepository(name: name, picture: picture);
  }
}
