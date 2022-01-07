import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/edit_service_category/edit_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/save_service_category/save_service_category_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'service_category_controller.g.dart';

@Injectable()
class ServiceCategoryController = _ServiceCategoryControllerBase
    with _$ServiceCategoryController;

abstract class _ServiceCategoryControllerBase with Store {
  final GetServiceCategoryUseCase _getServiceCategoryUsecase;
  final DeleteServiceCategoryUseCase _deleteServiceCategoryUseCase;
  final SaveServiceCategoryUseCase _saveServiceCategoryUseCase;
  final EditServiceCategoryUseCase _editServiceCategoryUseCase;

  _ServiceCategoryControllerBase(
      this._getServiceCategoryUsecase,
      this._deleteServiceCategoryUseCase,
      this._saveServiceCategoryUseCase,
      this._editServiceCategoryUseCase);

  @observable
  List<ServiceCategoryEntity> listServiceCategoryEntity = [];

  @observable
  Exception? error;

  @observable
  bool loading = false;

  @observable
  String? name;

  @observable
  String? picture;

  @action
  Future<void> getServiceCategory() async {
    loading = true;
    try {
      final result = await _getServiceCategoryUsecase();
      result.fold((_error) => error = _error,
          (_success) => listServiceCategoryEntity = _success);
    } catch (e) {
      error = Exception('Erro ao pegar categorias');
    } finally {
      loading = false;
    }
  }

  @action
  void setName(String _name) => name = _name;

  @action
  void setPicture(String? _picture) => picture = _picture;

  @action
  Future<ServiceCategoryEntity> updateServiceCategory(
      ServiceCategoryEntity entity) async {
    loading = true;
    try {
      var result = await _editServiceCategoryUseCase(entity);
      return result.fold(
          (error) => throw ('error in update'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<ServiceCategoryEntity> saveServiceCategory(
      {required String name, required String picture}) async {
    loading = true;
    try {
      var result =
          await _saveServiceCategoryUseCase(name: name, picture: picture);
      return result.fold(
          (error) => throw ('error in insert'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<int> deleteServiceCategory(int id) async {
    loading = true;
    try {
      var result = await _deleteServiceCategoryUseCase(id);
      return result.fold(
          (error) => throw ('error in delete'), (success) => success);
    } finally {
      loading = false;
    }
  }
}
