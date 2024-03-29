import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/delete_service_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/delete_service/delete_service_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'delete_service_usecase_imp.g.dart';

@Injectable(singleton: false)
class DeleteServiceUseCaseImp implements DeleteServiceUseCase {
  final DeleteServiceRepository _deleteServiceRepository;
  DeleteServiceUseCaseImp(this._deleteServiceRepository);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteServiceRepository(id);
  }
}
