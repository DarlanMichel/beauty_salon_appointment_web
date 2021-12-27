import 'package:beauty_salon_appointment_web/app/modules/service_category/data/dtos/service_category_dto.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SaveServiceCategoryDataSource {
  Future<Either<Exception, ServiceCategoryDto>> call(
      ServiceCategoryEntity serviceCategoryEntity);
}
