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
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/pages/service_category_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/pages/service_category_registration_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ServiceCategoryModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HasuraConnect(
        "https://beauty-salon-appointment.herokuapp.com/v1/graphql")),
    //datasource
    Bind.lazySingleton((i) => GetServiceCategoryHasuraDataSourceImp(i())),
    Bind.lazySingleton((i) => SaveServiceCategoryHasuraDataSourceImp(i())),
    Bind.lazySingleton((i) => EditServiceCategoryHasuraDataSourceImp(i())),
    Bind.lazySingleton((i) => DeleteServiceCategoryHasuraDataSourceImp(i())),
    //repositories
    Bind.lazySingleton((i) => GetServiceCategoryRepositoryImp(i())),
    Bind.lazySingleton((i) => SaveServiceCategoryRepositoryImp(i())),
    Bind.lazySingleton((i) => EditServiceCategoryRepositoryImp(i())),
    Bind.lazySingleton((i) => DeleteServiceCategoryRepositoryImp(i())),
    //useCases
    Bind.lazySingleton((i) => GetServiceCategoryUseCaseImp(i())),
    Bind.lazySingleton((i) => SaveServiceCategoryUseCaseImp(i())),
    Bind.lazySingleton((i) => EditServiceCategoryUseCaseImp(i())),
    Bind.lazySingleton((i) => DeleteServiceCategoryUseCaseImp(i())),
    //controllers
    Bind.lazySingleton((i) => ServiceCategoryController(i(), i(), i(), i())),
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
