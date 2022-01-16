import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/edit_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/edit_collaborator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'edit_collaborator_repository_imp.g.dart';

@Injectable(singleton: false)
class EditCollaboratorRepositoryImp implements EditCollaboratorRepository {
  final EditCollaboratorDataSource _editCollaboratorDataSource;
  EditCollaboratorRepositoryImp(this._editCollaboratorDataSource);

  @override
  Future<Either<Exception, CollaboratorEntity>> call(
      CollaboratorEntity serviceEntity) async {
    return await _editCollaboratorDataSource(serviceEntity);
  }
}
