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
        mutation saveCollaborator(\$name: String, \$picture: String,){
          insert_collaborators_one(object: {name: \$name, picture: \$picture}) {
            id
            name
            picture
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "name": collaboratorEntity.name,
        "picture": collaboratorEntity.picture,
      });
      serviceDto = CollaboratorDto.fromJson(snapshot['data']['insert_collaborators_one']);

      if(collaboratorEntity.servicesProvided!.isNotEmpty){
        for(var service in collaboratorEntity.servicesProvided!){
          var query = '''
        mutation saveCollaborator(\$percentage: numeric, \$price: numeric, \$service: Int, \$collaborator: Int){
          insert_collaborators_services(objects: {collaborator: \$collaborator, percentage: \$percentage, price: \$price, service: \$service}) {
            affected_rows
          }
        } ''';
          await _hasuraConnect.mutation(query, variables: {
            "percentage": service.percentage,
            "price": service.price,
            "service": service.service,
            "collaborator": serviceDto.id,
          });
        }
      }

      if(collaboratorEntity.schedules!.isNotEmpty){
        for(var schedule in collaboratorEntity.schedules!){
          var query = '''
        mutation saveCollaborator(\$week: String, \$start_morning: numeric, \$start_evening: numeric, \$end_morning: numeric, \$end_evening: numeric, \$collaborator: Int){
          insert_collaborators_schedules(objects: {collaborator: \$collaborator, end_evening: \$end_evening, end_morning: \$end_morning, start_evening: \$start_evening, start_morning: \$start_morning, week: \$week}) {
            affected_rows
          }
        } ''';
          await _hasuraConnect.mutation(query, variables: {
            "collaborator": serviceDto.id,
            "end_evening": schedule.endEvening,
            "end_morning": schedule.endMorning,
            "start_evening": schedule.startEvening,
            "start_morning": schedule.startMorning,
            "week": schedule.week,
          });
        }
      }

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
