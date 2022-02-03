import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_schedules_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_services_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';

class CollaboratorDto extends CollaboratorEntity {
  int? id;
  String name;
  String picture;
  List<CollaboratorServicesDto>? collaboratorServices;
  List<CollaboratorSchedulesDto>? collaboratorSchedules;

  CollaboratorDto(
      {this.id,
      required this.name,
      required this.picture,
      this.collaboratorServices,
      this.collaboratorSchedules})
      : super(
            id: id,
            name: name,
            picture: picture,
            servicesProvided: collaboratorServices,
            schedules: collaboratorSchedules);

  factory CollaboratorDto.fromJson(Map<String, dynamic> json) =>
      CollaboratorDto(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
        collaboratorSchedules: json["collaborators_schedules"] == null
            ? null
            : List<CollaboratorSchedulesDto>.from(
                json["collaborators_schedules"].map((x) => CollaboratorSchedulesDto.fromJson(x))),
        collaboratorServices: json["collaborators_services"] == null
            ? null
            : List<CollaboratorServicesDto>.from(
                json["collaborators_services"].map((x) => CollaboratorServicesDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "collaborators_schedules": collaboratorSchedules == null
            ? null
            : List<CollaboratorSchedulesDto>.from(collaboratorSchedules!.map((x) => x.toJson())),
        "collaborators_services": collaboratorServices == null
            ? null
            : List<CollaboratorServicesDto>.from(collaboratorServices!.map((x) => x.toJson())),
      };
}
