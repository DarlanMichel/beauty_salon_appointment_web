import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:beauty_salon_appointment_web/app/shared/convert_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardService extends StatelessWidget {
  final ServiceEntity service;
  const CardService({Key? key, required this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceBloc bloc =
    Modular.get<ServiceBloc>();
    final ServiceCategoryBloc blocCategory =
    Modular.get<ServiceCategoryBloc>();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      blocCategory.add(const ServiceCategoryFetchList());
    });
    return BlocBuilder<ServiceBloc, ServiceState>(
      bloc: bloc,
        builder: (context, state){
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

                    BlocBuilder<ServiceCategoryBloc, ServiceCategoryState>(
                      bloc: blocCategory,
                      builder: (context, state) {
                        if(state is ServiceCategoryStateLoading){
                          return const Text(
                            'Categoria: carregando...',
                            textScaleFactor: 1.2,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          );
                        }
                        if(state is ServiceCategoryStateSuccess){
                          List<ServiceCategoryEntity> listCategoryEntity = state.listServiceCategoryEntity;
                          String nameCategory = '';
                          for (var item in listCategoryEntity) {
                            if (item.id == service.category) {
                              nameCategory = item.name;
                              break;
                            }
                          }
                          return Text(
                            'Categoria: $nameCategory',
                            textScaleFactor: 1.2,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          );
                        }
                        return Container();
                      }
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Média de tempo: ${convertTime(service.serviceTime)}',
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
                      onPressed: () {
                        bloc.add(ServiceDelete(service.id!));
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
    );
  }
}
