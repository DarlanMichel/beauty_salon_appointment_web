import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_services_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardCollaborator extends StatelessWidget {
  final CollaboratorEntity collaborator;
  const CardCollaborator({Key? key, required this.collaborator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollaboratorBloc bloc =
    Modular.get<CollaboratorBloc>();
    final ServiceBloc blocService =
    Modular.get<ServiceBloc>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      blocService.add(const ServiceFetchList());
    });
    return BlocBuilder<CollaboratorBloc, CollaboratorState>(
      bloc: bloc,
      builder: (context, state){
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
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(70),
                          child: Image.network(
                            collaborator.picture,
                            height: 90,
                            width: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Nome: ${collaborator.name}',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        textScaleFactor: 1.3,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Serviços realizados: ',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    BlocBuilder<ServiceBloc, ServiceState>(
                      bloc: blocService,
                      builder: (context, state) {
                        if(state is ServiceStateLoading){
                          return const CircularProgressIndicator();
                        }
                        if(state is ServiceStateSuccess){
                          if(collaborator.servicesProvided == null){
                            return Container();
                          }else{
                            return SizedBox(
                              height: 35,
                              child: ListView.builder(
                                  itemCount: collaborator.servicesProvided!.length,
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemBuilder: (_, i) {
                                    CollaboratorServicesEntity service =
                                    collaborator.servicesProvided![i];
                                    String nameService = '';
                                    for (var item in state.listServiceEntity) {
                                      if (item.id == service.service) {
                                        nameService = item.name;
                                      }
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: Colors.grey),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          nameService,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                        }
                        return Container();
                      }
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                            bloc.add(CollaboratorDelete(collaborator.id!));
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
      },
    );
  }
}
