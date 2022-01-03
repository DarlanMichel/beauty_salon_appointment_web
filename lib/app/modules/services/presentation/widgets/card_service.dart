import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/controllers/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardService extends StatelessWidget {
  final ServiceEntity service;
  const CardService({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceController controller = Modular.get<ServiceController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Serviço: ${service.name}',
                  textScaleFactor: 1.7,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Observer(
                  builder: (context) {
                    return FutureBuilder(
                      future: controller.convertCategory(service.category),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasData
                          ? 'Categoria: ${snapshot.data}'
                          : 'Carregando...',
                          textScaleFactor: 1.2,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      }
                    );
                  }
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Média de tempo: ${controller.convertTime(service.serviceTime)}',
                  textScaleFactor: 1.2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pacote: ${service.package ? 'Sim' : 'Não'}',
                  textScaleFactor: 1.2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Modular.to.navigate('./new', arguments: service);
                  },
                  child: const Text(
                    'Editar',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Color.fromRGBO(97, 97, 97, 1),
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: const Size(110, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(
                  width: 27,
                ),
                ElevatedButton(
                  onPressed: () async {
                    int deleted = await controller.deleteService(service.id!);
                    if (deleted == 1) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Serviço ${service.name} removido com sucesso!'),
                              ));
                      await controller.getService();
                    }
                  },
                  child: const Text(
                    'Excluir',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.primary,
                    fixedSize: const Size(110, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
