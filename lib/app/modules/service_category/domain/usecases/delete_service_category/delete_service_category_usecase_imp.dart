import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/repositories/delete_service_category_repository.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'delete_service_category_usecase_imp.g.dart';

@Injectable(singleton: false)
class DeleteServiceCategoryUseCaseImp implements DeleteServiceCategoryUseCase {
  final DeleteServiceCategoryRepository _deleteServiceCategoryRepository;
  DeleteServiceCategoryUseCaseImp(this._deleteServiceCategoryRepository);

  @override
  Future<Either<Exception, int>> call(int id) async {
    return await _deleteServiceCategoryRepository(id);
  }
}
