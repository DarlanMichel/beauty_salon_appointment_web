import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/delete_collaborator_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator/delete_collaborator_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'delete_collaborator_usecase_imp.g.dart';

@Injectable(singleton: false)
class DeleteCollaboratorUseCaseImp implements DeleteCollaboratorUseCase {
  final DeleteCollaboratorRepository _deleteCollaboratorRepository;
  DeleteCollaboratorUseCaseImp(this._deleteCollaboratorRepository);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteCollaboratorRepository(id);
  }
}
