import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:dartz/dartz.dart';

abstract class GetCollaboratorDataSource {
  Future<Either<Exception, List<CollaboratorDto>>> call();
}
