import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/controllers/collaborator_controller.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/widgets/card_collaborator.dart';
import 'package:beauty_salon_appointment_web/app/shared/custom_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class CollaboratorPage extends StatefulWidget {
  const CollaboratorPage({Key? key}) : super(key: key);

  @override
  _CollaboratorPageState createState() => _CollaboratorPageState();
}

class _CollaboratorPageState extends ModularState<CollaboratorPage, CollaboratorController> {
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
      controller.getCollaborator();
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
              'Colaboradores',
              textScaleFactor: 3.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Faça o cadastro dos seus colaboradores, para que os usuarios do aplicativo possam selecionar a agenda do colaborador.',
              textScaleFactor: 1.3,
            ),
            const SizedBox(
              height: 50,
            ),
            Observer(builder: (context) {
              if (controller.listCollaboratorEntity.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                );
              } else {
                List<CollaboratorEntity> listCollaborator =
                    controller.listCollaboratorEntity;
                return LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth < 900) {
                    return ListView.builder(
                        itemCount: listCollaborator.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          CollaboratorEntity collaborator = listCollaborator[i];
                          return CardCollaborator(
                            collaborator: collaborator,
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
                        itemCount: listCollaborator.length,
                        itemBuilder: (context, i) {
                          CollaboratorEntity collaborator = listCollaborator[i];
                          return CardCollaborator(
                            collaborator: collaborator,
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
                    'Novo Colaborador',
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
