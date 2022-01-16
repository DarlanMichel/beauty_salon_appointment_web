import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SaveCollaboratorUseCase {
  Future<Either<Exception, CollaboratorEntity>> call(
      CollaboratorEntity collaboratorEntity);
}
