import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/get_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/dtos/service_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
part 'get_service_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class GetServiceHasuraDataSourceImp implements GetServiceDataSource {
  final HasuraConnect _hasuraConnect;
  GetServiceHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, List<ServiceDto>>> call() async {
    try {
      List<ServiceDto> listServices = [];
      ServiceDto serviceDto;
      var query = '''
        query getServices{
          services {
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
      var snapshot = await _hasuraConnect.query(query);
      for (var json in (snapshot['data']['services']) as List) {
        serviceDto = ServiceDto.fromJson(json);
        listServices.add(serviceDto);
      }
      return Right(listServices);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
