import 'package:beauty_salon_appointment_web/app/modules/service_category/data/dtos/service_category_dto.dart';
import 'package:dartz/dartz.dart';

abstract class DeleteServiceCategoryDataSource{
  Future<Either<Exception, ServiceCategoryDto>> call(int id);
}