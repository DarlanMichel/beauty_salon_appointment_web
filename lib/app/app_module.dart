import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    //AsyncBind((i) => SharedPreferences.getInstance()),
  ];

  @override
  final List<ModularRoute> routes = [
    WildcardRoute(
        child: (_, __) => const Scaffold(
              body: Center(
                child: Text('404 Not found'),
              ),
            )),
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
