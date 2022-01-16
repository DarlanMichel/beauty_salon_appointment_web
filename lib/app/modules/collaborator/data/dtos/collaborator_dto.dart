import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_schedules_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/dtos/collaborator_services_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';

class CollaboratorDto extends CollaboratorEntity {
  int? id;
  String name;
  String picture;
  List<CollaboratorServicesDto> collaboratorServices;
  List<CollaboratorSchedulesDto> collaboratorSchedules;

  CollaboratorDto(
      {this.id,
      required this.name,
      required this.picture,
      required this.collaboratorServices,
      required this.collaboratorSchedules})
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
        collaboratorSchedules: List<CollaboratorSchedulesDto>.from(
            json["collaborators_schedules"]
                .map((x) => CollaboratorSchedulesDto.fromJson(x))),
        collaboratorServices: List<CollaboratorServicesDto>.from(
            json["collaborators_services"]
                .map((x) => CollaboratorServicesDto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
        "collaborators_schedules":
            List<dynamic>.from(collaboratorSchedules.map((x) => x.toJson())),
        "collaborators_services":
            List<dynamic>.from(collaboratorServices.map((x) => x.toJson())),
      };
}
