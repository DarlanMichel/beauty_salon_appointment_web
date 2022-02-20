import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorServiceUseCase {
  Future<Either<Exception, int>> call(int id);
}