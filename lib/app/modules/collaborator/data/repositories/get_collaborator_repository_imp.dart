import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/get_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/repositories/get_collaborator_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'get_collaborator_repository_imp.g.dart';

@Injectable(singleton: false)
class GetCollaboratorRepositoryImp implements GetCollaboratorRepository {
  final GetCollaboratorDataSource _getCollaboratorDataSource;
  GetCollaboratorRepositoryImp(this._getCollaboratorDataSource);

  @override
  Future<Either<Exception, List<CollaboratorEntity>>> call() async {
    return await _getCollaboratorDataSource();
  }
}