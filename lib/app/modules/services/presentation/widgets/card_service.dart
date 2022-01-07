import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/controllers/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardService extends StatefulWidget {
  final ServiceEntity service;
  const CardService({Key? key, required this.service}) : super(key: key);

  @override
  State<CardService> createState() => _CardServiceState();
}

class _CardServiceState extends ModularState<CardService, ServiceController> {
  String? nameCategory;
  @override
  void initState() {
    super.initState();
    setState(() {
      nameCategory = controller.setNameCategory(widget.service.category);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  'Serviço: ${widget.service.name}',
                  textScaleFactor: 1.7,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                  Text(
                    'Categoria: $nameCategory',
                    textScaleFactor: 1.2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Média de tempo: ${controller.convertTime(widget.service.serviceTime)}',
                  textScaleFactor: 1.2,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pacote: ${widget.service.package ? 'Sim' : 'Não'}',
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
                    Modular.to.navigate('./new', arguments: widget.service);
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
                    int deleted =
                        await controller.deleteService(widget.service.id!);
                    if (deleted == 1) {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(
                                    'Serviço ${widget.service.name} removido com sucesso!'),
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
