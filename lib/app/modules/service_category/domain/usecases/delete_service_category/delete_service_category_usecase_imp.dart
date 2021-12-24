import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/delete_service_category_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:dartz/dartz.dart';

class DeleteServiceCategoryUseCaseImp implements DeleteServiceCategoryUseCase{
  final DeleteServiceCategoryRepository _deleteServiceCategoryRepository;
  DeleteServiceCategoryUseCaseImp(this._deleteServiceCategoryRepository);

  @override
  Future<Either<Exception, ServiceCategoryEntity>> call(int id) async {
    return await _deleteServiceCategoryRepository(id);
  }

}