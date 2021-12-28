import 'package:dartz/dartz.dart';

abstract class DeleteServiceDataSource {
  Future<Either<Exception, int>> call(int id);
}
