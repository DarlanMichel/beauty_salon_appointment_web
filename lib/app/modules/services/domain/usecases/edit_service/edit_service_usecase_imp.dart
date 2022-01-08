import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/edit_service_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/edit_service/edit_service_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'edit_service_usecase_imp.g.dart';

@Injectable(singleton: false)
class EditServiceUseCaseImp implements EditServiceUseCase {
  final EditServiceRepository _editServiceRepository;
  EditServiceUseCaseImp(this._editServiceRepository);

  @override
  Future<Either<Exception, ServiceEntity>> call(
      ServiceEntity serviceEntity) async {
    return await _editServiceRepository(serviceEntity);
  }
}
