import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_services_entity.dart';

class CollaboratorServicesDto extends CollaboratorServicesEntity {
  int? id;
  int service;
  double price;
  double percentage;

  CollaboratorServicesDto(
      {this.id,
        required this.service,
        required this.price,
        required this.percentage,})
      : super(
      id: id,
      service: service,
  price: price,
  percentage: percentage);

  factory CollaboratorServicesDto.fromJson(Map<String, dynamic> json) =>
      CollaboratorServicesDto(
        id: json["id"],
        percentage: json["percentage"],
        price: json["price"],
        service: json["service"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "percentage": percentage,
    "price": price,
    "service": service,
  };
}