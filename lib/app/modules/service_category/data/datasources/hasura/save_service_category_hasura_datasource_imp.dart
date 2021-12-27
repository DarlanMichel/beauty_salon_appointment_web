import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/save_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/dtos/service_category_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class SaveServiceCategoryHasuraDataSourceImp
    implements SaveServiceCategoryDataSource {
  final HasuraConnect _hasuraConnect;
  SaveServiceCategoryHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, ServiceCategoryDto>> call(
      {required String name, required String picture}) async {
    try {
      ServiceCategoryDto serviceCategoryDto;
      var query = '''
        mutation saveServiceCategory(\$name: String, \$picture: String){
          insert_service_category_one(object: {name: \$name, picture: \$picture}) {
            id
            name
            picture
          }
        } ''';
      var snapshot = await _hasuraConnect
          .mutation(query, variables: {"name": name, "picture": picture});
      serviceCategoryDto = ServiceCategoryDto.fromJson(
          snapshot['data']['insert_service_category_one']);

      return Right(serviceCategoryDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
