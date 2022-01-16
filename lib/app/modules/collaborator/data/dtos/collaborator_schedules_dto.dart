import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_schedules_entity.dart';

class CollaboratorSchedulesDto extends CollaboratorSchedulesEntity {
  int? id;
  String week;
  double startMorning;
  double endMorning;
  double? startEvening;
  double? endEvening;

  CollaboratorSchedulesDto(
      {this.id,
      required this.week,
      required this.startMorning,
      required this.endMorning,
      this.startEvening,
      this.endEvening})
      : super(
            id: id,
            week: week,
            startMorning: startMorning,
            endMorning: endMorning,
            startEvening: startEvening,
            endEvening: endEvening);

  factory CollaboratorSchedulesDto.fromJson(Map<String, dynamic> json) =>
      CollaboratorSchedulesDto(
        endEvening:
            json["end_evening"] == null ? null : json["end_evening"].toDouble(),
        endMorning: json["end_morning"],
        id: json["id"],
        startEvening: json["start_evening"] == null
            ? null
            : json["start_evening"].toDouble(),
        startMorning: json["start_morning"].toDouble(),
        week: json["week"],
      );

  Map<String, dynamic> toJson() => {
        "end_evening": endEvening == null ? null : endEvening,
        "end_morning": endMorning,
        "id": id,
        "start_evening": startEvening == null ? null : startEvening,
        "start_morning": startMorning,
        "week": week,
      };
}
