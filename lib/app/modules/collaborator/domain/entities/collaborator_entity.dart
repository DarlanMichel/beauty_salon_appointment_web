import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_schedules_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_services_entity.dart';

class CollaboratorEntity {
  int? id;
  String name;
  String picture;
  List<CollaboratorServicesEntity>? servicesProvided;
  List<CollaboratorSchedulesEntity>? schedules;

  CollaboratorEntity(
      {this.id,
      required this.name,
      required this.picture,
      this.servicesProvided,
      this.schedules});
}
