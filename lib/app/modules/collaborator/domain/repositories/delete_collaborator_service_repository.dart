import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorServiceRepository {
  Future<Either<Exception, int>> call(int id);
}
