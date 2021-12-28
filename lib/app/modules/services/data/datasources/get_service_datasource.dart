import 'package:beauty_salon_appointment_web/app/modules/services/data/dtos/service_dto.dart';
import 'package:dartz/dartz.dart';

abstract class GetServiceDataSource {
  Future<Either<Exception, List<ServiceDto>>> call();
}
