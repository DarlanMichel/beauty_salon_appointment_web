import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/delete_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/delete_service_category_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteServiceCategoryRepositoryImp
    implements DeleteServiceCategoryRepository {
  final DeleteServiceCategoryDataSource _deleteServiceCategoryDataSource;
  DeleteServiceCategoryRepositoryImp(this._deleteServiceCategoryDataSource);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteServiceCategoryDataSource(id);
  }
}
