import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/save_collaborator_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/save_collaborator/save_collaborator_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'save_collaborator_usecase_imp.g.dart';

@Injectable(singleton: false)
class SaveCollaboratorUseCaseImp implements SaveCollaboratorUseCase {
  final SaveCollaboratorRepository _saveCollaboratorRepository;
  SaveCollaboratorUseCaseImp(this._saveCollaboratorRepository);

  @override
  Future<Either<Exception, CollaboratorEntity>> call(
      CollaboratorEntity collaboratorEntity) async {
    return await _saveCollaboratorRepository(collaboratorEntity);
  }
}
