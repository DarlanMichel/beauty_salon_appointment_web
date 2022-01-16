import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/delete_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/delete_collaborator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'delete_collaborator_repository_imp.g.dart';

@Injectable(singleton: false)
class DeleteCollaboratorRepositoryImp implements DeleteCollaboratorRepository {
  final DeleteCollaboratorDataSource _deleteCollaboratorDataSource;
  DeleteCollaboratorRepositoryImp(this._deleteCollaboratorDataSource);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteCollaboratorDataSource(id);
  }
}