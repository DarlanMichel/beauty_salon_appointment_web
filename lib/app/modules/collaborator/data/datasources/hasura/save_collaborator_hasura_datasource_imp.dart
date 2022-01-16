import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/save_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part 'save_collaborator_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class SaveCollaboratorHasuraDataSourceImp implements SaveCollaboratorDataSource {
  final HasuraConnect _hasuraConnect;
  SaveCollaboratorHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, CollaboratorDto>> call(
      CollaboratorEntity collaboratorEntity) async {
    try {
      CollaboratorDto serviceDto;
      var query = '''
        mutation saveCollaborator(\$name: String, \$picture: String, \$end_evening: numeric, \$end_morning: numeric, \$start_evening: numeric, \$start_morning: numeric, \$week: String, \$percentage: numeric, \$price: numeric, \$service: Int){
          insert_services_one(object: {name: \$name, picture: \$picture, collaborators_schedules: {data: {end_evening: \$end_evening, end_morning: \$end_morning, start_evening: \$start_evening, start_morning: \$start_morning, week: \$week}}, collaborators_services: {data: {percentage: \$percentage, price: \$price, service: \$service}}}) {
            id
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
              service
              price
              percentage
            }
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "name": collaboratorEntity.name,
        "picture": collaboratorEntity.picture,
      });
      serviceDto = CollaboratorDto.fromJson(snapshot['data']['insert_collaborators_one']);

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
