import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:mobx/mobx.dart';

part 'service_category_controller.g.dart';

class ServiceCategoryController = _ServiceCategoryControllerBase with _$ServiceCategoryController;
abstract class _ServiceCategoryControllerBase with Store {
  late final GetServiceCategoryUseCase _getServiceCategoryUsecase;

  _ServiceCategoryControllerBase(this._getServiceCategoryUsecase){
    getServiceCategory();
  }

  @observable
  List<ServiceCategoryEntity>? listServiceCategoryEntity;

  @action
  getServiceCategory() async {
    var result = await _getServiceCategoryUsecase();
    result.fold((error) => print(error.toString()), (success) => listServiceCategoryEntity = success);
  } 
}