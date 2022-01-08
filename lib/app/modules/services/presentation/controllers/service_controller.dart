import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/delete_service/delete_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/edit_service/edit_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/get_service/get_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/save_service/save_service_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'service_controller.g.dart';

@Injectable()
class ServiceController = _ServiceControllerBase with _$ServiceController;

abstract class _ServiceControllerBase with Store {
  final GetServiceUseCase _getServiceUsecase;
  final DeleteServiceUseCase _deleteServiceUseCase;
  final SaveServiceUseCase _saveServiceUseCase;
  final EditServiceUseCase _editServiceUseCase;

  _ServiceControllerBase(this._getServiceUsecase, this._deleteServiceUseCase,
      this._saveServiceUseCase, this._editServiceUseCase);

  @observable
  List<ServiceEntity> listServiceEntity = [];

  @observable
  List<ServiceCategoryEntity> listCategoryEntity = [];

  @observable
  Exception? error;

  @observable
  String? name;

  @observable
  String nameCategory = '';

  @observable
  ServiceCategoryEntity? category;

  @observable
  bool package = false;

  @observable
  bool loading = false;

  @observable
  bool haveWaiting = false;

  @action
  Future<void> getService() async {
    loading = true;
    try {
      var result = await _getServiceUsecase();
      result.fold((_error) => error = _error,
          (_success) => listServiceEntity = _success);
    } catch (e) {
      error = Exception('Erro ao pegar serviços');
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> getCategory() async {
    loading = true;
    try {
      final categoryController = Modular.get<ServiceCategoryController>();
      await categoryController.getServiceCategory();
      listCategoryEntity = categoryController.listServiceCategoryEntity;
    } catch (e) {
      error = Exception('Erro ao pegar categorias');
    } finally {
      loading = false;
    }
  }

  @action
  void setName(String _name) => name = _name;

  @action
  void setCategory(ServiceCategoryEntity _category) => category = _category;

  @action
  void setPackage(bool _package) => package = _package;

  @action
  void setHaveWaiting(bool _haveWaiting) => haveWaiting = _haveWaiting;

  @action
  Future<ServiceEntity> updateService(ServiceEntity entity) async {
    loading = true;
    try {
      var result = await _editServiceUseCase(entity);
      return result.fold(
          (error) => throw ('error in update'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<ServiceEntity> saveService(ServiceEntity serviceEntity) async {
    loading = true;
    try {
      var result = await _saveServiceUseCase(serviceEntity);
      return result.fold(
          (error) => throw ('error in insert'), (success) => success);
    } finally {
      loading = false;
    }
  }

  @action
  Future<int> deleteService(int id) async {
    loading = true;
    try {
      var result = await _deleteServiceUseCase(id);
      return result.fold(
          (error) => throw ('error in delete'), (success) => success);
    } finally {
      loading = false;
    }
  }

  String convertTime(double time) {
    int fullTime = (time * 100).toInt();
    if (fullTime < 100) {
      return '$fullTime min';
    } else {
      var hour =
          fullTime.toString().substring(0, fullTime.toString().length - 2);
      var min = fullTime.toString().substring(fullTime.toString().length - 2);
      return '$hour h $min min';
    }
  }

  @action
  String setNameCategory(int category) {
    for (var item in listCategoryEntity) {
      if (item.id == category) {
        nameCategory = item.name;
      }
    }
    return nameCategory;
  }
}
