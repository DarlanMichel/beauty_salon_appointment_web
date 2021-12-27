import 'package:dartz/dartz.dart';

abstract class DeleteServiceCategoryDataSource {
  Future<Either<Exception, int>> call(int id);
}
