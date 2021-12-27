import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/edit_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/edit_service_category_repository.dart';
import 'package:dartz/dartz.dart';

class EditServiceCategoryRepositoryImp
    implements EditServiceCategoryRepository {
  final EditServiceCategoryDataSource _editServiceCategoryDataSource;
  EditServiceCategoryRepositoryImp(this._editServiceCategoryDataSource);

  @override
  Future<Either<Exception, ServiceCategoryEntity>> call(
      ServiceCategoryEntity serviceCategoryEntity) async {
    return await _editServiceCategoryDataSource(serviceCategoryEntity);
  }
}
