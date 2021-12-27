import 'package:beauty_salon_appointment_web/app/modules/home/presentation/ui/pages/home_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/home/presentation/ui/widgets/content_home_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/service_category_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => HomePage(),children: [
      ChildRoute('/home', child: (context, args) => const ContentHomePage()),
      ModuleRoute('/serviceCategory', module: ServiceCategoryModule()),
    ]),
  ];
}