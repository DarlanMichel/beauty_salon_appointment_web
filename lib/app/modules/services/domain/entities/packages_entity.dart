class PackagesEntity {
  int? id;
  int service;
  int? collaborator;
  double? serviceTime;
  bool? betweenWait;

  PackagesEntity(
      {this.id,
      required this.service,
      this.collaborator,
      this.serviceTime,
      this.betweenWait});
}
