import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorUseCase {
  Future<Either<Exception, int>> call(int id);
}
