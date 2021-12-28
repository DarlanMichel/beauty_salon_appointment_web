import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/packages_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';

class ServiceDto extends ServiceEntity {
  int? id;
  String name;
  int category;
  bool package;
  double serviceTime;
  double? waitingTime;
  bool haveWaiting;
  double? postWaitTime;
  List<PackagesEntity>? extraServices;

  ServiceDto(
      {this.id,
      required this.name,
      required this.category,
      required this.package,
      required this.serviceTime,
      this.waitingTime,
      required this.haveWaiting,
      this.postWaitTime,
      this.extraServices})
      : super(
            id: id,
            name: name,
            category: category,
            package: package,
            serviceTime: serviceTime,
            waitingTime: waitingTime,
            haveWaiting: haveWaiting,
            postWaitTime: postWaitTime,
            extraServices: extraServices);

  factory ServiceDto.fromJson(Map<String, dynamic> json) => ServiceDto(
      id: json["id"],
      name: json["name"],
      category: json["category"],
      package: json["package"],
      serviceTime: json["service_time"],
      waitingTime: json["waiting_time"],
      haveWaiting: json["have_waiting"],
      postWaitTime: json["post_wait_time"],
      extraServices: json["extra_services"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "package": package,
        "service_time": serviceTime,
        "waiting_time": waitingTime,
        "have_waiting": haveWaiting,
        "post_wait_time": postWaitTime,
        "extra_services": extraServices,
      };
}
