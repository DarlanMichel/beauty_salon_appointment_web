import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/edit_service_category_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/edit_service_category/edit_service_category_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'edit_service_category_usecase_imp.g.dart';

@Injectable(singleton: false)
class EditServiceCategoryUseCaseImp implements EditServiceCategoryUseCase {
  final EditServiceCategoryRepository _editServiceCategoryRepository;
  EditServiceCategoryUseCaseImp(this._editServiceCategoryRepository);

  @override
  Future<Either<Exception, ServiceCategoryEntity>> call(
      ServiceCategoryEntity serviceCategoryEntity) async {
    return await _editServiceCategoryRepository(serviceCategoryEntity);
  }
}
