import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/save_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/dtos/service_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class SaveServiceHasuraDataSourceImp implements SaveServiceDataSource {
  final HasuraConnect _hasuraConnect;
  SaveServiceHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, ServiceDto>> call(
      ServiceEntity serviceEntity) async {
    try {
      ServiceDto serviceDto;
      var query = '''
        mutation saveService(\$name: String, \$category: Int, \$have_waiting: Boolean, \$package: Boolean, \$post_wait_time: numeric, \$service_time: numeric, \$waiting_time: numeric){
          insert_services_one(object: {category: \$category, extra_services: null, have_waiting: \$have_waiting, name: \$name, package: \$package, post_wait_time: \$post_wait_time, service_time: \$service_time, waiting_time: \$waiting_time}) {
            category
            extra_services
            have_waiting
            id
            name
            package
            post_wait_time
            service_time
            waiting_time
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "name": serviceEntity.name,
        "category": serviceEntity.category,
        "have_waiting": serviceEntity.haveWaiting,
        "package": serviceEntity.package,
        "post_wait_time": serviceEntity.postWaitTime,
        "service_time": serviceEntity.serviceTime,
        "waiting_time": serviceEntity.waitingTime,
      });
      serviceDto = ServiceDto.fromJson(snapshot['data']['insert_services_one']);

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
