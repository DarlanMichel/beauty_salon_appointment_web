import 'package:beauty_salon_appointment_web/app/modules/service_category/serviceCategory_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/serviceCategory', module: ServiceCategoryModule())
  ];

}