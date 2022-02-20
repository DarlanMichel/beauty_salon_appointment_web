import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/delete_collaborator_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';
part 'delete_collaborator_hasura_datasource_imp.g.dart';

@Injectable(singleton: false)
class DeleteCollaboratorHasuraDataSourceImp implements DeleteCollaboratorDataSource {
  final HasuraConnect _hasuraConnect;
  DeleteCollaboratorHasuraDataSourceImp(this._hasuraConnect);

  @override
  Future<Either<Exception, int>> call(int id) async {
    try {
      int affectedRow = 0;

      var sheduleQuery = '''
        mutation deleteSchedule(\$id: Int){
          delete_collaborators_schedules(where: {collaborator: {_eq: \$id}}) {
            affected_rows
          }
        } ''';

      await _hasuraConnect.mutation(sheduleQuery, variables: {"id": id});

      var serviceQuery = '''
        mutation deleteService(\$id: Int){
          delete_collaborators_services(where: {collaborator: {_eq: \$id}}) {
            affected_rows
          }
        } ''';

      await _hasuraConnect.mutation(serviceQuery, variables: {"id": id});

      var query = '''
        mutation deleteCollaborator(\$id: Int){
          delete_collaborators(where: {id: {_eq: \$id}}) {
            affected_rows
          }
        } ''';
      var snapshot =
      await _hasuraConnect.mutation(query, variables: {"id": id});

      affectedRow = snapshot['data']['delete_collaborators']['affected_rows'];

      return Right(affectedRow);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}