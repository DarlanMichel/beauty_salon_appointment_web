import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';

class ServiceCategoryDto extends ServiceCategoryEntity {
  int? id;
  String name;
  String picture;

  ServiceCategoryDto({this.id, required this.name, required this.picture})
      : super(id: id, name: name, picture: picture);

  factory ServiceCategoryDto.fromJson(Map<String, dynamic> json) =>
      ServiceCategoryDto(
        id: json["id"],
        name: json["name"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "picture": picture,
      };
}
