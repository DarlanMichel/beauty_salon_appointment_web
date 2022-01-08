import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/get_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/get_service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'get_service_repository_imp.g.dart';

@Injectable(singleton: false)
class GetServiceRepositoryImp implements GetServiceRepository {
  final GetServiceDataSource _getServiceDataSource;
  GetServiceRepositoryImp(this._getServiceDataSource);

  @override
  Future<Either<Exception, List<ServiceEntity>>> call() async {
    return await _getServiceDataSource();
  }
}
