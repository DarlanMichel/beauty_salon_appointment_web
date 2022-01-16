import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/get_collaborator_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/get_collaborator/get_collaborator_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'get_collaborator_usecase_imp.g.dart';

@Injectable(singleton: false)
class GetCollaboratorUseCaseImp implements GetCollaboratorUseCase {
  final GetCollaboratorRepository _getCollaboratorRepository;
  GetCollaboratorUseCaseImp(this._getCollaboratorRepository);

  @override
  Future<Either<Exception, List<CollaboratorEntity>>> call() async {
    return await _getCollaboratorRepository();
  }
}
