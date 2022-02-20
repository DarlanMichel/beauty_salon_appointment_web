import 'package:dartz/dartz.dart';

abstract class DeleteCollaboratorServiceDataSource {
  Future<Either<Exception, int>> call(int id);
}