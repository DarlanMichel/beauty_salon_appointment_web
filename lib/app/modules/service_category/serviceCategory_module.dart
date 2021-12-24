import 'package:beauty_salon_appointment_web/app/modules/service_category/data/datasources/hasura/get_service_category_hasura_datasource_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/data/repositories/get_service_category_repository_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/usecases/get_service_category/get_service_category_usecase_imp.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/pages/service_category_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura_connect/hasura_connect.dart';

class ServiceCategoryModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i)=> HasuraConnect("https://beauty-salon-appointment.herokuapp.com/v1/graphql")),
    //datasource
    Bind.lazySingleton((i) => GetServiceCategoryHasuraDataSourceImp(i.get())),
    //repositories
    Bind.lazySingleton((i) => GetServiceCategoryRepositoryImp(i.get())),
    //usecases
    Bind.lazySingleton((i) => GetServiceCategoryUseCaseImp(i.get())),
    //controllers
    Bind.lazySingleton((i) => ServiceCategoryController(i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => ServiceCategoryPage()),
  ];
}
