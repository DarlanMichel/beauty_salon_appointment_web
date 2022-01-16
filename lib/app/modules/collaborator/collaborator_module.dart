import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/delete_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/edit_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/get_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/save_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/delete_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/edit_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/get_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/save_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator/delete_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/edit_collaborator/edit_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/get_collaborator/get_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/save_collaborator/save_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/controllers/collaborator_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/pages/collaborator_page.dart';
import 'package:beauty_salon_appointment_web/app/shared/hasura_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomHasuraConnect.getConnect()),
    //datasource
    $GetCollaboratorHasuraDataSourceImp,
    $SaveCollaboratorHasuraDataSourceImp,
    $EditCollaboratorHasuraDataSourceImp,
    $DeleteCollaboratorHasuraDataSourceImp,
    //repositories
    $GetCollaboratorRepositoryImp,
    $SaveCollaboratorRepositoryImp,
    $EditCollaboratorRepositoryImp,
    $DeleteCollaboratorRepositoryImp,
    //useCases
    $GetCollaboratorUseCaseImp,
    $SaveCollaboratorUseCaseImp,
    $EditCollaboratorUseCaseImp,
    $DeleteCollaboratorUseCaseImp,
    //controllers
    $CollaboratorController,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const CollaboratorPage()),
    // ChildRoute('/new',
    //     child: (context, args) => CollaboratorRegistrationPage(
    //         entity: args.data
    //     ))
  ];

}