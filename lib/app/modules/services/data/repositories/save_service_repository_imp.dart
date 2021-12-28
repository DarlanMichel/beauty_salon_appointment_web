import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/save_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/save_service_repository.dart';
import 'package:dartz/dartz.dart';

class SaveServiceRepositoryImp implements SaveServiceRepository {
  final SaveServiceDataSource _saveServiceDataSource;
  SaveServiceRepositoryImp(this._saveServiceDataSource);

  @override
  Future<Either<Exception, ServiceEntity>> call(
      ServiceEntity serviceEntity) async {
    return await _saveServiceDataSource(serviceEntity);
  }
}
