import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/widgets/card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends ModularState<ServicePage, ServiceBloc> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bloc.add(const ServiceFetchList());
    });

    bloc.stream.listen((state) {
      if (state is ServiceStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
        bloc.add(const ServiceFetchList());
      }
      if (state is ServiceStateDeleted) {
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
                  title: Text('Serviço removido com sucesso!'),
                ));
        bloc.add(const ServiceFetchList());
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
            BlocBuilder<ServiceBloc, ServiceState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ServiceStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ServiceStateSuccess) {
                    if (state.listServiceEntity.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                      );
                    } else {
                      List<ServiceEntity> listService = state.listServiceEntity;
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
