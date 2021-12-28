import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/save_service_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/save_service/save_service_usecase.dart';
import 'package:dartz/dartz.dart';

class SaveServiceUseCaseImp implements SaveServiceUseCase {
  final SaveServiceRepository _saveServiceRepository;
  SaveServiceUseCaseImp(this._saveServiceRepository);

  @override
  Future<Either<Exception, ServiceEntity>> call(
      ServiceEntity serviceEntity) async {
    return await _saveServiceRepository(serviceEntity);
  }
}
