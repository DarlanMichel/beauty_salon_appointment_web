import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/edit_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part 'edit_collaborator_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class EditCollaboratorHasuraDataSourceImp implements EditCollaboratorDataSource {
  final HasuraConnect _hasuraConnect;
  EditCollaboratorHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, CollaboratorDto>> call(
      CollaboratorEntity collaboratorEntity) async {
    try {
      CollaboratorDto serviceDto;
      var query = '''
        mutation updateCollaborators(\$id: Int!, \$name: String, \$picture: String, \$end_evening: numeric, \$end_morning: numeric, \$start_evening: numeric, \$start_morning: numeric, \$week: String, \$percentage: numeric, \$price: numeric, \$service: Int){
          update_collaborators_by_pk(pk_columns: {id: \$id}, _set: {name: \$name, picture: \$picture}) {
            name
            picture
            collaborators_schedules {
              end_evening
              end_morning
              start_evening
              start_morning
              week
            }
            collaborators_services {
              percentage
              price
              service
            }
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "id": collaboratorEntity.id,
        "name": collaboratorEntity.name,
        "picture": collaboratorEntity.picture,
      });
      serviceDto =
          CollaboratorDto.fromJson(snapshot['data']['update_collaborators_by_pk']);

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
