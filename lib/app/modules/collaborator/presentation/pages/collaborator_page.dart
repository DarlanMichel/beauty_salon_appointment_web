import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/widgets/card_collaborator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CollaboratorPage extends StatefulWidget {
  const CollaboratorPage({Key? key}) : super(key: key);

  @override
  _CollaboratorPageState createState() => _CollaboratorPageState();
}

class _CollaboratorPageState
    extends ModularState<CollaboratorPage, CollaboratorBloc> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bloc.add(const CollaboratorFetchList());
    });

    bloc.stream.listen((state) {
      if (state is CollaboratorStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
        bloc.add(const CollaboratorFetchList());
      }
      if (state is CollaboratorStateDeleted) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  title: Text('Colaborador removido com sucesso!'),
                ));
        bloc.add(const CollaboratorFetchList());
      }
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
            BlocBuilder<CollaboratorBloc, CollaboratorState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CollaboratorStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CollaboratorStateSuccess) {
                    if (state.listCollaboratorEntity.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                      );
                    } else {
                      List<CollaboratorEntity> listCollaborator =
                          state.listCollaboratorEntity;
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 900) {
                          return ListView.builder(
                              itemCount: listCollaborator.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                CollaboratorEntity collaborator =
                                    listCollaborator[i];
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
                                CollaboratorEntity collaborator =
                                    listCollaborator[i];
                                return CardCollaborator(
                                  collaborator: collaborator,
                                );
                              });
                        }
                      });
                    }
                  }
                  return Container();
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
                    fixedSize: const Size(175, 40),
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
