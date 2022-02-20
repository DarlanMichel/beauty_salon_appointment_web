import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/edit_collaborator_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_schedules_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_services_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part 'edit_collaborator_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class EditCollaboratorHasuraDataSourceImp
    implements EditCollaboratorDataSource {
  final HasuraConnect _hasuraConnect;
  EditCollaboratorHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, CollaboratorDto>> call(
      CollaboratorEntity collaboratorEntity) async {
    try {
      CollaboratorDto serviceDto;
      var query = '''
        mutation updateCollaborators(\$name: String, \$picture: String, \$id: Int!){
          update_collaborators_by_pk(pk_columns: {id: \$id}, _set: {name: \$name, picture: \$picture}) {
            id
            name
            picture
            collaborators_services {
              id
              percentage
              price
              service
            }
            collaborators_schedules {
              end_evening
              end_morning
              id
              start_evening
              start_morning
              week
            }
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "id": collaboratorEntity.id,
        "name": collaboratorEntity.name,
        "picture": collaboratorEntity.picture,
      });
      serviceDto = CollaboratorDto.fromJson(
          snapshot['data']['update_collaborators_by_pk']);

      if (collaboratorEntity.servicesProvided!.isNotEmpty) {
        for (var service in collaboratorEntity.servicesProvided!) {
          if (serviceDto.servicesProvided != null) {
            var dto = serviceDto.servicesProvided!;
            var exist = dto.firstWhere((element) => element.id == service.id,
                orElse: () => CollaboratorServicesDto(
                    service: 0, price: 0, percentage: 0));
            if (exist.id != null) {
              var editQuery = '''
                  mutation saveCollaborator(\$id: Int!, \$service: Int, \$price: numeric, \$percentage: numeric){
                    update_collaborators_services_by_pk(pk_columns: {id: \$id}, _set: {percentage: \$percentage, price: \$price, service: \$service}) {
                      collaborator
                      id
                      percentage
                      price
                      service
                    }
                  } ''';
              await _hasuraConnect.mutation(editQuery, variables: {
                "percentage": service.percentage,
                "price": service.price,
                "service": service.service,
                "id": service.id,
              });
            } else {
              var saveQuery = '''
                  mutation saveCollaborator(\$percentage: numeric, \$price: numeric, \$service: Int, \$collaborator: Int){
                    insert_collaborators_services(objects: {collaborator: \$collaborator, percentage: \$percentage, price: \$price, service: \$service}) {
                      affected_rows
                    }
                  } ''';
              await _hasuraConnect.mutation(saveQuery, variables: {
                "percentage": service.percentage,
                "price": service.price,
                "service": service.service,
                "collaborator": serviceDto.id,
              });
            }
          } else {
            var saveQuery = '''
              mutation saveCollaborator(\$percentage: numeric, \$price: numeric, \$service: Int, \$collaborator: Int){
                insert_collaborators_services(objects: {collaborator: \$collaborator, percentage: \$percentage, price: \$price, service: \$service}) {
                  affected_rows
                }
              } ''';
            await _hasuraConnect.mutation(saveQuery, variables: {
              "percentage": service.percentage,
              "price": service.price,
              "service": service.service,
              "collaborator": serviceDto.id,
            });
          }
        }
      }

      if (collaboratorEntity.schedules!.isNotEmpty) {
        for (var schedule in collaboratorEntity.schedules!) {
          if (serviceDto.schedules != null) {
            var dto = serviceDto.schedules!;
            var exist = dto.firstWhere((element) => element.id == schedule.id,
                orElse: () => CollaboratorSchedulesDto(
                    week: '', startMorning: 0, endMorning: 0));
            if (exist.id != null) {
              var editQuery = '''
                  mutation saveCollaborator(\$id: Int!, \$end_evening: numeric, \$end_morning: numeric, \$start_evening: numeric, \$start_morning: numeric, \$week: String){
                    update_collaborators_schedules_by_pk(pk_columns: {id: \$id}, _set: {end_evening: \$end_evening, end_morning: \$end_morning, start_evening: \$start_evening, start_morning: \$start_morning, week: \$week}) {
                      end_evening
                      end_morning
                      start_evening
                      collaborator
                      id
                      start_morning
                      week
                    }
                  } ''';
              await _hasuraConnect.mutation(editQuery, variables: {
                "id": schedule.id,
                "end_evening": schedule.endEvening,
                "end_morning": schedule.endMorning,
                "start_evening": schedule.startEvening,
                "start_morning": schedule.startMorning,
                "week": schedule.week,
              });
            } else {
              var saveQuery = '''
                  mutation saveCollaborator(\$week: String, \$start_morning: numeric, \$start_evening: numeric, \$end_morning: numeric, \$end_evening: numeric, \$collaborator: Int){
                    insert_collaborators_schedules(objects: {collaborator: \$collaborator, end_evening: \$end_evening, end_morning: \$end_morning, start_evening: \$start_evening, start_morning: \$start_morning, week: \$week}) {
                      affected_rows
                    }
                  } ''';
              await _hasuraConnect.mutation(saveQuery, variables: {
                "collaborator": serviceDto.id,
                "end_evening": schedule.endEvening,
                "end_morning": schedule.endMorning,
                "start_evening": schedule.startEvening,
                "start_morning": schedule.startMorning,
                "week": schedule.week,
              });
            }
          } else {
            var saveQuery = '''
              mutation saveCollaborator(\$week: String, \$start_morning: numeric, \$start_evening: numeric, \$end_morning: numeric, \$end_evening: numeric, \$collaborator: Int){
                insert_collaborators_schedules(objects: {collaborator: \$collaborator, end_evening: \$end_evening, end_morning: \$end_morning, start_evening: \$start_evening, start_morning: \$start_morning, week: \$week}) {
                  affected_rows
                }
              } ''';
            await _hasuraConnect.mutation(saveQuery, variables: {
              "collaborator": serviceDto.id,
              "end_evening": schedule.endEvening,
              "end_morning": schedule.endMorning,
              "start_evening": schedule.startEvening,
              "start_morning": schedule.startMorning,
              "week": schedule.week,
            });
          }
        }
      }

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
