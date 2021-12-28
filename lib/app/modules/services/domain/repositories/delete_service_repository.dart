import 'package:dartz/dartz.dart';

abstract class DeleteServiceRepository {
  Future<Either<Exception, int>> call(int id);
}
