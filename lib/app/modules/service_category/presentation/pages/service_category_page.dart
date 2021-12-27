import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/widgets/card_service_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryPageState createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState
    extends ModularState<ServiceCategoryPage, ServiceCategoryController> {
  @override
  void initState() {
    super.initState();
    controller.getServiceCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorias de Serviços',
            textScaleFactor: 3.5,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Faça o cadastro das categorias de serviços prestados pelo salão, para que seja apresentado na tela inicial do aplicativo',
            textScaleFactor: 1.3,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Observer(builder: (context) {
              if (controller.listServiceCategoryEntity == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<ServiceCategoryEntity> listCategory =
                    controller.listServiceCategoryEntity!;
                if (listCategory.isEmpty) {
                  return const Center(
                    child: Text('Sem categorias cadastradas!'),
                  );
                } else {
                  return ListView.builder(
                      itemCount: listCategory.length,
                      itemBuilder: (context, i) {
                        ServiceCategoryEntity category = listCategory[i];
                        return CardServiceCategory(
                          category: category,
                        );
                      });
                }
              }
            }),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Modular.to.navigate('./new');
                },
                child: const Text(
                  'Nova Categoria',
                  textScaleFactor: 1.2,
                  style: TextStyle(
                      color: Color.fromRGBO(97, 97, 97, 1),
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  fixedSize: const Size(150, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
