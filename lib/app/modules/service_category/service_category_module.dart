import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/hasura/delete_service_category_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/hasura/edit_service_category_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/hasura/get_service_category_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/hasura/save_service_category_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/repositories/delete_service_category_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/repositories/edit_service_category_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/repositories/get_service_category_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/repositories/save_service_category_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/delete_service_category/delete_service_category_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/edit_service_category/edit_service_category_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/save_service_category/save_service_category_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/pages/service_category_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/pages/service_category_registration_page.dart';
import 'package:beauty_salon_appointment_web/app/shared/hasura_connect.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceCategoryModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => CustomHasuraConnect.getConnect()),
    //datasource
    Bind.lazySingleton((i) => GetServiceCategoryHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceCategoryHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceCategoryHasuraDataSourceImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceCategoryHasuraDataSourceImp(i()), export: true),
    //repositories
    Bind.lazySingleton((i) => GetServiceCategoryRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceCategoryRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceCategoryRepositoryImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceCategoryRepositoryImp(i()), export: true),
    //useCases
    Bind.lazySingleton((i) => GetServiceCategoryUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => SaveServiceCategoryUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => EditServiceCategoryUseCaseImp(i()), export: true),
    Bind.lazySingleton((i) => DeleteServiceCategoryUseCaseImp(i()), export: true),
    //controllers
    Bind.lazySingleton((i) => ServiceCategoryBloc(i(), i(), i(), i()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const ServiceCategoryPage()),
    ChildRoute('/new',
        child: (context, args) => ServiceCategoryRegistrationPage(
              entity: args.data,
            ))
  ];
}
