import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/edit_service_category/edit_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/save_service_category/save_service_category_usecase.dart';
import 'package:mobx/mobx.dart';

part 'service_category_controller.g.dart';

class ServiceCategoryController = _ServiceCategoryControllerBase
    with _$ServiceCategoryController;

abstract class _ServiceCategoryControllerBase with Store {
  late final GetServiceCategoryUseCase _getServiceCategoryUsecase;
  late final DeleteServiceCategoryUseCase _deleteServiceCategoryUseCase;
  late final SaveServiceCategoryUseCase _saveServiceCategoryUseCase;
  late final EditServiceCategoryUseCase _editServiceCategoryUseCase;

  _ServiceCategoryControllerBase(
      this._getServiceCategoryUsecase,
      this._deleteServiceCategoryUseCase,
      this._saveServiceCategoryUseCase,
      this._editServiceCategoryUseCase) {
    getServiceCategory();
  }

  @observable
  List<ServiceCategoryEntity>? listServiceCategoryEntity;

  @observable
  String? name;

  @observable
  String? picture;

  @action
  getServiceCategory() async {
    var result = await _getServiceCategoryUsecase();
    result.fold((error) => print(error.toString()),
        (success) => listServiceCategoryEntity = success);
  }

  @action
  void setName(String _name) => name = _name;

  @action
  void setPicture(String? _picture) => picture = _picture;

  Future<ServiceCategoryEntity> updateServiceCategory(
      ServiceCategoryEntity entity) async {
    var result = await _editServiceCategoryUseCase(entity);
    return result.fold(
        (error) => throw ('error in update'), (success) => success);
  }

  Future<ServiceCategoryEntity> saveServiceCategory(
      {required String name, required String picture}) async {
    var result =
        await _saveServiceCategoryUseCase(name: name, picture: picture);
    return result.fold(
        (error) => throw ('error in insert'), (success) => success);
  }

  Future<int> deleteServiceCategory(int id) async {
    var result = await _deleteServiceCategoryUseCase(id);
    return result.fold(
        (error) => throw ('error in delete'), (success) => success);
  }
}
