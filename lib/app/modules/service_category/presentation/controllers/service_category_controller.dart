import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:mobx/mobx.dart';

part 'service_category_controller.g.dart';

class ServiceCategoryController = _ServiceCategoryControllerBase
    with _$ServiceCategoryController;

abstract class _ServiceCategoryControllerBase with Store {
  late final GetServiceCategoryUseCase _getServiceCategoryUsecase;
  late final DeleteServiceCategoryUseCase _deleteServiceCategoryUseCase;

  _ServiceCategoryControllerBase(
      this._getServiceCategoryUsecase, this._deleteServiceCategoryUseCase) {
    getServiceCategory();
  }

  @observable
  List<ServiceCategoryEntity>? listServiceCategoryEntity;

  @action
  getServiceCategory() async {
    var result = await _getServiceCategoryUsecase();
    result.fold((error) => print(error.toString()),
        (success) => listServiceCategoryEntity = success);
  }

  Future<int> deleteServiceCategory(int id) async {
    var result = await _deleteServiceCategoryUseCase(id);
    return result.fold((error) => 0, (success) => success);
  }
}
