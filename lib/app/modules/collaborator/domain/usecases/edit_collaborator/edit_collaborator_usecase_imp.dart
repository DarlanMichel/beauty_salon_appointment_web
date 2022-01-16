import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/edit_collaborator_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/edit_collaborator/edit_collaborator_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'edit_collaborator_usecase_imp.g.dart';

@Injectable(singleton: false)
class EditCollaboratorUseCaseImp implements EditCollaboratorUseCase {
  final EditCollaboratorRepository _editCollaboratorRepository;
  EditCollaboratorUseCaseImp(this._editCollaboratorRepository);

  @override
  Future<Either<Exception, CollaboratorEntity>> call(
      CollaboratorEntity collaboratorEntity) async {
    return await _editCollaboratorRepository(collaboratorEntity);
  }
}
