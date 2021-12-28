import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/edit_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/edit_service_repository.dart';
import 'package:dartz/dartz.dart';

class EditServiceRepositoryImp implements EditServiceRepository {
  final EditServiceDataSource _editServiceDataSource;
  EditServiceRepositoryImp(this._editServiceDataSource);

  @override
  Future<Either<Exception, ServiceEntity>> call(
      ServiceEntity serviceEntity) async {
    return await _editServiceDataSource(serviceEntity);
  }
}
