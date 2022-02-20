import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/delete_collaborator_service_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

part 'delete_collaborator_service_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class DeleteCollaboratorServiceHasuraDataSourceImp implements DeleteCollaboratorServiceDataSource {
  final HasuraConnect _hasuraConnect;
  DeleteCollaboratorServiceHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, int>> call(int id) async {
    try {
      int affectedRow = 0;

      var serviceQuery = '''
        mutation deleteService(\$id: Int){
          delete_collaborators_services(where: {id: {_eq: \$id}}) {
            affected_rows
          }
        } ''';

      var snapshot = await _hasuraConnect.mutation(serviceQuery, variables: {"id": id});

      affectedRow = snapshot['data']['delete_collaborators_services']['affected_rows'];

      return Right(affectedRow);
    } catch (e) {
      return Left(Exception(e));
    }
  }

}