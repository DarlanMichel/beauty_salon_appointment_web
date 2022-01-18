import 'dart:async';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/delete_service/delete_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/edit_service/edit_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/get_service/get_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/save_service/save_service_usecase.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final GetServiceUseCase _getServiceUsecase;
  final DeleteServiceUseCase _deleteServiceUseCase;
  final SaveServiceUseCase _saveServiceUseCase;
  final EditServiceUseCase _editServiceUseCase;

  ServiceBloc(this._getServiceUsecase, this._deleteServiceUseCase,
      this._saveServiceUseCase, this._editServiceUseCase)
      : super(ServiceStateIdle()) {
    on<ServiceFetchList>(_fetchList);
    on<ServiceDelete>(_delete);
    on<ServiceUpdate>(_update);
    on<ServiceInsert>(_insert);
  }

  FutureOr<ServiceState?> _fetchList(
      ServiceFetchList event, Emitter<ServiceState> emit) async {
    emit(ServiceStateLoading());

    try {
      final result = await _getServiceUsecase();
      result.fold((_error) => emit(ServiceStateError(_error)),
          (_success) => emit(ServiceStateSuccess(_success)));
    } catch (error) {
      emit(ServiceStateError(error));
    }
  }

  FutureOr<ServiceState?> _delete(
      ServiceDelete event, Emitter<ServiceState> emit) async {
    emit(ServiceStateLoading());

    try {
      final result = await _deleteServiceUseCase(event.id);
      result.fold((_error) => emit(ServiceStateError(_error)),
          (_success) => emit(ServiceStateDeleted(_success)));
    } catch (error) {
      emit(ServiceStateError(error));
    }
  }

  FutureOr<ServiceState?> _update(
      ServiceUpdate event, Emitter<ServiceState> emit) async {
    emit(ServiceStateLoading());

    try {
      final result = await _editServiceUseCase(event.entity);
      result.fold((_error) => emit(ServiceStateError(_error)),
          (_success) => emit(ServiceStateSaved(_success)));
    } catch (error) {
      emit(ServiceStateError(error));
    }
  }

  FutureOr<ServiceState?> _insert(
      ServiceInsert event, Emitter<ServiceState> emit) async {
    emit(ServiceStateLoading());

    try {
      final result = await _saveServiceUseCase(event.entity);
      result.fold((_error) => emit(ServiceStateError(_error)),
          (_success) => emit(ServiceStateSaved(_success)));
    } catch (error) {
      emit(ServiceStateError(error));
    }
  }


}

