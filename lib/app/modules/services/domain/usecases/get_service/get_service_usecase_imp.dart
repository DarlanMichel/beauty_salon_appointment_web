import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/repositories/get_service_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/get_service/get_service_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'get_service_usecase_imp.g.dart';

@Injectable(singleton: false)
class GetServiceUseCaseImp implements GetServiceUseCase {
  final GetServiceRepository _getServiceRepository;
  GetServiceUseCaseImp(this._getServiceRepository);

  @override
  Future<Either<Exception, List<ServiceEntity>>> call() async {
    return await _getServiceRepository();
  }
}
