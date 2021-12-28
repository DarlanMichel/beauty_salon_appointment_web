import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/controllers/service_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/widgets/card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends ModularState<ServicePage, ServiceController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Serviços Prestados',
              textScaleFactor: 3.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Faça o cadastro dos serviços prestados pelos colaboradores, para que o cliente selecione o serviço que deseja',
              textScaleFactor: 1.3,
            ),
            const SizedBox(
              height: 50,
            ),
            Observer(builder: (context) {
              if (controller.listServiceEntity == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<ServiceEntity> listService = controller.listServiceEntity!;
                if (listService.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Center(
                      child: Text(
                        'Sem serviços cadastrados!',
                        textScaleFactor: 2.5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth < 900) {
                      return ListView.builder(
                          itemCount: listService.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            ServiceEntity service = listService[i];
                            return CardService(
                              service: service,
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
                          itemCount: listService.length,
                          itemBuilder: (context, i) {
                            ServiceEntity service = listService[i];
                            return CardService(
                              service: service,
                            );
                          });
                    }
                  });
                }
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
                    'Novo Serviço',
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
