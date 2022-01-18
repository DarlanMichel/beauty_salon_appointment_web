import 'package:beauty_salon_appointment_web/app/modules/service_category/service_category_module.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/hasura/delete_service_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/hasura/edit_service_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/hasura/get_service_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/datasources/hasura/save_service_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/repositories/delete_service_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/repositories/edit_service_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/repositories/get_service_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/data/repositories/save_service_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/delete_service/delete_service_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/edit_service/edit_service_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/get_service/get_service_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/usecases/save_service/save_service_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/pages/service_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/pages/service_registration_page.dart';
import 'package:beauty_salon_appointment_web/app/shared/hasura_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomHasuraConnect.getConnect()),
    //datasource
    Bind.lazySingleton((i) => GetServiceHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceHasuraDataSourceImp(i()), export: true),
    //repositories
    Bind.lazySingleton((i) => GetServiceRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceRepositoryImp(i()), export: true),
    //useCases
    Bind.lazySingleton((i) => GetServiceUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceUseCaseImp(i()), export: true),
    //controllers
    Bind.lazySingleton((i) => ServiceBloc(i(), i(), i(), i()), export: true),
  ];

  @override
  List<Module> get imports => [
    ServiceCategoryModule()
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const ServicePage()),
    ChildRoute('/new',
        child: (context, args) => ServiceRegistrationPage(
          entity: args.data
        ))
  ];

}