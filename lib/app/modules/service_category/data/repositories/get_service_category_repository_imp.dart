import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/get_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/get_service_category_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'get_service_category_repository_imp.g.dart';

@Injectable(singleton: false)
class GetServiceCategoryRepositoryImp implements GetServiceCategoryRepository {
  final GetServiceCategoryDataSource _getServiceCategoryDataSource;
  GetServiceCategoryRepositoryImp(this._getServiceCategoryDataSource);

  @override
  Future<Either<Exception, List<ServiceCategoryEntity>>> call() async {
    return await _getServiceCategoryDataSource();
  }
}
