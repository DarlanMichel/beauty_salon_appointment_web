import 'package:beauty_salon_appointment_web/app/modules/services/data/dtos/service_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SaveServiceDataSource {
  Future<Either<Exception, ServiceDto>> call(ServiceEntity serviceEntity);
}
