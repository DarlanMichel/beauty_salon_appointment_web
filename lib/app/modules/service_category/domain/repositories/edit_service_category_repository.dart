import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class EditServiceCategoryRepository{
  Future<Either<Exception, ServiceCategoryEntity>> call(ServiceCategoryEntity serviceCategoryEntity);
}