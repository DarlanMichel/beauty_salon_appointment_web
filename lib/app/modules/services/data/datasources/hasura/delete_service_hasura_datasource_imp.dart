import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/delete_service_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:hasura_connect/hasura_connect.dart';

class DeleteServiceHasuraDataSourceImp implements DeleteServiceDataSource {
  final HasuraConnect _hasuraConnect;
  DeleteServiceHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, int>> call(int id) async {
    try {
      int affectedRow = 0;
      var query = '''
        mutation deleteService(\$id: Int){
          delete_services(where: {id: {_eq: \$id}}) {
            affected_rows
          }
        } ''';
      var snapshot =
          await _hasuraConnect.mutation(query, variables: {"id": id});

      affectedRow = snapshot['data']['delete_services']['affected_rows'];

      return Right(affectedRow);
    } catch (e) {
      return Left(Exception('Hasura datasource error'));
    }
  }
}
