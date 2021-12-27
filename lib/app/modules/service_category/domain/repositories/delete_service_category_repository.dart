import 'package:dartz/dartz.dart';

abstract class DeleteServiceCategoryRepository {
  Future<Either<Exception, int>> call(int id);
}
