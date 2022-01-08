import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/edit_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/dtos/service_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
part 'edit_service_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class EditServiceHasuraDataSourceImp implements EditServiceDataSource {
  final HasuraConnect _hasuraConnect;
  EditServiceHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, ServiceDto>> call(
      ServiceEntity serviceEntity) async {
    try {
      ServiceDto serviceDto;
      var query = '''
        mutation updateServices(\$id: Int!, \$name: String, \$category: Int, \$have_waiting: Boolean, \$package: Boolean, \$post_wait_time: numeric, \$service_time: numeric, \$waiting_time: numeric){
          update_services_by_pk(pk_columns: {id: \$id}, _set: {category: \$category, extra_services: null, have_waiting: \$have_waiting, name: \$name, package: \$package, post_wait_time: \$post_wait_time, service_time: \$service_time, waiting_time: \$waiting_time}) {
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
        "id": serviceEntity.id,
        "name": serviceEntity.name,
        "category": serviceEntity.category,
        "have_waiting": serviceEntity.haveWaiting,
        "package": serviceEntity.package,
        "post_wait_time": serviceEntity.postWaitTime,
        "service_time": serviceEntity.serviceTime,
        "waiting_time": serviceEntity.waitingTime,
      });
      serviceDto =
          ServiceDto.fromJson(snapshot['data']['update_services_by_pk']);

      return Right(serviceDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
