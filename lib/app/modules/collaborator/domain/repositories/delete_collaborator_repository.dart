import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorRepository {
  Future<Either<Exception, int>> call(int id);
}
