import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/get_service_category_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:dartz/dartz.dart';

class GetServiceCategoryUseCaseImp implements GetServiceCategoryUseCase{
  final GetServiceCategoryRepository _getServiceCategoryRepository;
  GetServiceCategoryUseCaseImp(this._getServiceCategoryRepository);

  @override
  Future<Either<Exception, List<ServiceCategoryEntity>>> call() async{
    return await _getServiceCategoryRepository();
  }

}