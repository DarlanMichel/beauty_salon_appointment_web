import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/delete_service_datasource.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/delete_service_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'delete_service_repository_imp.g.dart';

@Injectable(singleton: false)
class DeleteServiceRepositoryImp implements DeleteServiceRepository {
  final DeleteServiceDataSource _deleteServiceDataSource;
  DeleteServiceRepositoryImp(this._deleteServiceDataSource);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteServiceDataSource(id);
  }
}
