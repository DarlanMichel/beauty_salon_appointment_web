import 'package:beauty_salon_appointment_web/app/modules/collaborator/collaborator_module.dart';
import 'package:beauty_salon_appointment_web/app/modules/home/presentation/pages/home_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/home/presentation/widgets/content_home_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/service_category_module.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/service_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => const HomePage(),children: [
      ChildRoute('/home', child: (context, args) => const ContentHomePage()),
      ModuleRoute('/serviceCategory', module: ServiceCategoryModule()),
      ModuleRoute('/service', module: ServiceModule()),
      ModuleRoute('/collaborator', module: CollaboratorModule()),
    ]),
  ];
}