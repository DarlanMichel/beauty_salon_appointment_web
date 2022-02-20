import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/delete_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/delete_collaborator_service_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/edit_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/get_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/datasources/hasura/save_collaborator_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/delete_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/delete_collaborator_service_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/edit_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/get_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/data/repositories/save_collaborator_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator/delete_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/delete_collaborator_service/delete_collaborator_service_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/edit_collaborator/edit_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/get_collaborator/get_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/usecases/save_collaborator/save_collaborator_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/pages/collaborator_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/pages/collaborator_registration_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/service_module.dart';
import 'package:beauty_salon_appointment_web/app/shared/hasura_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomHasuraConnect.getConnect()),
    //datasource
    Bind.lazySingleton((i) => GetCollaboratorHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => SaveCollaboratorHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => EditCollaboratorHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorServiceHasuraDataSourceImp(i()), export: true),
    //repositories
    Bind.lazySingleton((i) => GetCollaboratorRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => SaveCollaboratorRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => EditCollaboratorRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorServiceRepositoryImp(i()), export: true),
    //useCases
    Bind.lazySingleton((i) => GetCollaboratorUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => SaveCollaboratorUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => EditCollaboratorUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteCollaboratorServiceUseCaseImp(i()), export: true),
    //controllers
    Bind.lazySingleton((i) => CollaboratorBloc(i(), i(), i(), i(), i()), export: true),
  ];

  @override
  List<Module> get imports => [
    ServiceModule()
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const CollaboratorPage()),
    ChildRoute('/new',
        child: (context, args) => CollaboratorRegistrationPage(
            entity: args.data
        ))
  ];

}