import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ServiceCategoryEvent extends Equatable {
  const ServiceCategoryEvent();
  @override
  List<Object> get props => [];
}

class ServiceCategoryFetchList extends ServiceCategoryEvent {
  const ServiceCategoryFetchList();
  @override
  List<Object> get props => [];
}

class ServiceCategoryDelete extends ServiceCategoryEvent {
  final int id;
  const ServiceCategoryDelete(this.id);
  @override
  List<Object> get props => [id];
}

class ServiceCategoryUpdate extends ServiceCategoryEvent {
  final ServiceCategoryEntity entity;
  const ServiceCategoryUpdate(this.entity);
  @override
  List<Object> get props => [entity];
}

class ServiceCategoryInsert extends ServiceCategoryEvent {
  final String name;
  final String picture;
  const ServiceCategoryInsert({required this.name, required this.picture});
  @override
  List<Object> get props => [name, picture];
}