import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/packages_entity.dart';

class ServiceEntity {
  int? id;
  String name;
  int category;
  bool package;
  double serviceTime;
  double? waitingTime;
  bool haveWaiting;
  double? postWaitTime;
  List<PackagesEntity>? extraServices;

  ServiceEntity(
      {this.id,
      required this.name,
      required this.category,
      required this.package,
      required this.serviceTime,
      this.waitingTime,
      required this.haveWaiting,
      this.postWaitTime,
      this.extraServices});
}
