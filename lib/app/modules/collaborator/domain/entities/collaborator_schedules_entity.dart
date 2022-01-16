class CollaboratorSchedulesEntity {
  int? id;
  String week;
  double startMorning;
  double endMorning;
  double? startEvening;
  double? endEvening;

  CollaboratorSchedulesEntity(
      {this.id,
      required this.week,
      required this.startMorning,
      required this.endMorning,
      this.startEvening,
      this.endEvening});
}
