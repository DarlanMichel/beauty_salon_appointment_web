import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';

abstract class GetServiceRepository {
  Future<Either<Exception, List<ServiceEntity>>> call();
}