import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/widgets/card_service_category.dart';
import 'package:beauty_salon_appointment_web/app/shared/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryPageState createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState
    extends ModularState<ServiceCategoryPage, ServiceCategoryController> {
  final overlayLoading = OverlayEntry(builder: (_) {
    return const CustomOverlay();
  });

  @override
  void initState() {
    super.initState();
    reaction((_) => controller.error, (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    reaction<bool>((_) => controller.loading, (isLoading) {
      if (isLoading) {
        Overlay.of(context)?.insert(overlayLoading);
      } else {
        overlayLoading.remove();
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      controller.getServiceCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
            Observer(builder: (context) {
              if (controller.listServiceCategoryEntity.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                );
              } else {
                List<ServiceCategoryEntity> listCategory =
                    controller.listServiceCategoryEntity;
                return LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth < 900) {
                    return ListView.builder(
                        itemCount: listCategory.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          ServiceCategoryEntity category = listCategory[i];
                          return CardServiceCategory(
                            category: category,
                          );
                        });
                  } else {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 15,
                                crossAxisCount: 2,
                                mainAxisExtent: 160),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: listCategory.length,
                        itemBuilder: (context, i) {
                          ServiceCategoryEntity category = listCategory[i];
                          return CardServiceCategory(
                            category: category,
                          );
                        });
                  }
                });
              }
            }),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 30),
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
      ),
    );
  }
}
