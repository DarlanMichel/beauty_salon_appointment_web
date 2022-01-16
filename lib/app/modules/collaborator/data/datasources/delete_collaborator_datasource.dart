import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorDataSource {
  Future<Either<Exception, int>> call(int id);
}
