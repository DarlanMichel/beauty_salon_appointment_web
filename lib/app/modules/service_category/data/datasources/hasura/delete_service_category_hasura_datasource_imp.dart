import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/delete_service_category_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class DeleteServiceCategoryHasuraDataSourceImp
    implements DeleteServiceCategoryDataSource {
  final HasuraConnect _hasuraConnect;
  DeleteServiceCategoryHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, int>> call(int id) async {
    try {
      int affectedRow = 0;
      var query = '''
        mutation deleteServiceCategory(\$id: Int){
          delete_service_category(where: {id: {_eq: \$id}}) {
            affected_rows
          }
        } ''';
      var snapshot =
          await _hasuraConnect.mutation(query, variables: {"id": id});

      affectedRow =
          snapshot['data']['delete_service_category']['affected_rows'];

      return Right(affectedRow);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
