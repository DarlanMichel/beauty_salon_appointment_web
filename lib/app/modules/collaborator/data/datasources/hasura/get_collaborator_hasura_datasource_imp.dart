import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/get_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part 'get_collaborator_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class GetCollaboratorHasuraDataSourceImp implements GetCollaboratorDataSource {
  final HasuraConnect _hasuraConnect;
  GetCollaboratorHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, List<CollaboratorDto>>> call() async {
    try {
      List<CollaboratorDto> listCollaborators = [];
      CollaboratorDto colaboratorDto;
      var query = '''
        query getCollaborators{
          collaborators {
            id
            name
            picture
            collaborators_schedules {
              end_evening
              end_morning
              id
              start_evening
              start_morning
              week
            }
            collaborators_services {
              id
              percentage
              price
              service
            }
          }
        } ''';
      var snapshot = await _hasuraConnect.query(query);
      for (var json in (snapshot['data']['collaborators']) as List) {
        colaboratorDto = CollaboratorDto.fromJson(json);
        listCollaborators.add(colaboratorDto);
      }
      return Right(listCollaborators);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
