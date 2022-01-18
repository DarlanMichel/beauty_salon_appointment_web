import 'dart:async';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/edit_service_category/edit_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/save_service_category/save_service_category_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceCategoryBloc
    extends Bloc<ServiceCategoryEvent, ServiceCategoryState> {
  final GetServiceCategoryUseCase _getServiceCategoryUsecase;
  final DeleteServiceCategoryUseCase _deleteServiceCategoryUseCase;
  final SaveServiceCategoryUseCase _saveServiceCategoryUseCase;
  final EditServiceCategoryUseCase _editServiceCategoryUseCase;

  ServiceCategoryBloc(
      this._getServiceCategoryUsecase,
      this._deleteServiceCategoryUseCase,
      this._saveServiceCategoryUseCase,
      this._editServiceCategoryUseCase)
      : super(ServiceCategoryStateIdle()) {
    on<ServiceCategoryFetchList>(_fetchList);
    on<ServiceCategoryDelete>(_delete);
    on<ServiceCategoryUpdate>(_update);
    on<ServiceCategoryInsert>(_insert);
  }

  FutureOr<ServiceCategoryState?> _fetchList(ServiceCategoryFetchList event,
      Emitter<ServiceCategoryState> emit) async {
    emit(ServiceCategoryStateLoading());

    try {
      final result = await _getServiceCategoryUsecase();
      result.fold((_error) => emit(ServiceCategoryStateError(_error)),
          (_success) => emit(ServiceCategoryStateSuccess(_success)));
    } catch (error) {
      emit(ServiceCategoryStateError(error));
    }
  }

  FutureOr<ServiceCategoryState?> _delete(
      ServiceCategoryDelete event, Emitter<ServiceCategoryState> emit) async {
    emit(ServiceCategoryStateLoading());

    try {
      final result = await _deleteServiceCategoryUseCase(event.id);
      result.fold((_error) => emit(ServiceCategoryStateError(_error)),
          (_success) => emit(ServiceCategoryStateDeleted(_success)));
    } catch (error) {
      emit(ServiceCategoryStateError(error));
    }
  }

  FutureOr<ServiceCategoryState?> _update(
      ServiceCategoryUpdate event, Emitter<ServiceCategoryState> emit) async {
    emit(ServiceCategoryStateLoading());

    try {
      final result = await _editServiceCategoryUseCase(event.entity);
      result.fold((_error) => emit(ServiceCategoryStateError(_error)),
          (_success) => emit(ServiceCategoryStateSaved(_success)));
    } catch (error) {
      emit(ServiceCategoryStateError(error));
    }
  }

  FutureOr<ServiceCategoryState?> _insert(
      ServiceCategoryInsert event, Emitter<ServiceCategoryState> emit) async {
    emit(ServiceCategoryStateLoading());

    try {
      final result = await _saveServiceCategoryUseCase(
          name: event.name, picture: event.picture);
      result.fold((_error) => emit(ServiceCategoryStateError(_error)),
          (_success) => emit(ServiceCategoryStateSaved(_success)));
    } catch (error) {
      emit(ServiceCategoryStateError(error));
    }
  }
}
