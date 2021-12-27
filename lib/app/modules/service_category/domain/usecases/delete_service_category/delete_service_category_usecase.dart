import 'package:dartz/dartz.dart';

abstract class DeleteServiceCategoryUseCase {
  Future<Either<Exception, int>> call(int id);
}
