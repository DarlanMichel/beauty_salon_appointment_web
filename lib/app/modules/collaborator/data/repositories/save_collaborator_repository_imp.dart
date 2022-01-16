import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/save_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/save_collaborator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'save_collaborator_repository_imp.g.dart';

@Injectable(singleton: false)
class SaveCollaboratorRepositoryImp implements SaveCollaboratorRepository {
  final SaveCollaboratorDataSource _saveCollaboratorDataSource;
  SaveCollaboratorRepositoryImp(this._saveCollaboratorDataSource);

  @override
  Future<Either<Exception, CollaboratorEntity>> call(
      CollaboratorEntity serviceEntity) async {
    return await _saveCollaboratorDataSource(serviceEntity);
  }
}