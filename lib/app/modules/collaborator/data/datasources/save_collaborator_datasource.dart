import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SaveCollaboratorDataSource {
  Future<Either<Exception, CollaboratorDto>> call(
      CollaboratorEntity serviceEntity);
}
