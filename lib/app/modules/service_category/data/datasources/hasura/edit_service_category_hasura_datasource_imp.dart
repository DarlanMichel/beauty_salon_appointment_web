import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/edit_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/dtos/service_category_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class EditServiceCategoryHasuraDataSourceImp
    implements EditServiceCategoryDataSource {
  final HasuraConnect _hasuraConnect;
  EditServiceCategoryHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, ServiceCategoryDto>> call(
      ServiceCategoryEntity serviceCategoryEntity) async {
    try {
      ServiceCategoryDto serviceCategoryDto;
      var query = '''
        mutation updateServiceCategory(\$id: Int!, \$name: String, \$picture: String){
          update_service_category_by_pk(pk_columns: {id: \$id}, _set: {name: \$name, picture: \$picture}) {
            id
            name
            picture
          }
        } ''';
      var snapshot = await _hasuraConnect.mutation(query, variables: {
        "id": serviceCategoryEntity.id,
        "name": serviceCategoryEntity.name,
        "picture": serviceCategoryEntity.picture
      });
      serviceCategoryDto = ServiceCategoryDto.fromJson(
          snapshot['data']['update_service_category_by_pk']);

      return Right(serviceCategoryDto);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
