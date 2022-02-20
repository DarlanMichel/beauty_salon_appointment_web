import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/delete_collaborator_service_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator_service/delete_collaborator_service_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'delete_collaborator_service_usecase_imp.g.dart';

@Injectable(singleton: false)
class DeleteCollaboratorServiceUseCaseImp implements DeleteCollaboratorServiceUseCase {
  final DeleteCollaboratorServiceRepository _deleteCollaboratorServiceRepository;
  DeleteCollaboratorServiceUseCaseImp(this._deleteCollaboratorServiceRepository);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteCollaboratorServiceRepository(id);
  }
}