import 'package:dartz/dartz.dart';

abstract class DeleteServiceUseCase {
  Future<Either<Exception, int>> call(int id);
}
