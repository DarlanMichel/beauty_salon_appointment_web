import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/save_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/save_service_category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'save_service_category_repository_imp.g.dart';

@Injectable(singleton: false)
class SaveServiceCategoryRepositoryImp
    implements SaveServiceCategoryRepository {
  final SaveServiceCategoryDataSource _saveServiceCategoryDataSource;
  SaveServiceCategoryRepositoryImp(this._saveServiceCategoryDataSource);

  @override
  Future<Either<Exception, ServiceCategoryEntity>> call(
      {required String name, required String picture}) async {
    return await _saveServiceCategoryDataSource(name: name, picture: picture);
  }
}
