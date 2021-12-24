import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/get_service_category_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/dtos/service_category_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class GetServiceCategoryHasuraDataSourceImp implements GetServiceCategoryDataSource{
  final HasuraConnect _hasuraConnect;
  GetServiceCategoryHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, List<ServiceCategoryDto>>> call() async{
    try{
      List<ServiceCategoryDto> listCategories = [];
      ServiceCategoryDto serviceCategoryDto;
      var query = '''
        query getServiceCategory{
          service_category {
            id
            name
            picture
          }
        } ''';
      var snapshot = await _hasuraConnect.query(query);
      for (var json in (snapshot['data']['service_category']) as List) {
        serviceCategoryDto = ServiceCategoryDto.fromJson(json);
        listCategories.add(serviceCategoryDto);
      }
      return Right(listCategories);
    }catch(e){
      return Left(Exception('Hasura datasource error'));
    }

  }

}