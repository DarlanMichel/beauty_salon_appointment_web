import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_services_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/controllers/collaborator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardCollaborator extends StatelessWidget {
  final CollaboratorEntity collaborator;
  const CardCollaborator({Key? key, required this.collaborator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollaboratorController controller =
        Modular.get<CollaboratorController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                  child: Image.network(
                    collaborator.picture,
                    height: 90,
                    width: 90,
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nome: ${collaborator.name}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      'Serviços realizados: ',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: ListView.builder(
                          itemCount: collaborator.servicesProvided.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, i) {
                            CollaboratorServicesEntity service =
                            collaborator.servicesProvided[i];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.grey),
                              child: Text(
                                service.service.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate('./new', arguments: collaborator);
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
                        int deleted = await controller
                            .deleteCollaborator(collaborator.id!);
                        if (deleted == 1) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        'Categoria ${collaborator.name} removida com sucesso!'),
                                  ));
                          await controller.getCollaborator();
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
            )
          ],
        ),
      ),
    );
  }
}
