import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/widgets/time_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceRegistrationPage extends StatefulWidget {
  final ServiceEntity? entity;
  const ServiceRegistrationPage({Key? key, @Data this.entity})
      : super(key: key);

  @override
  _ServiceRegistrationPageState createState() =>
      _ServiceRegistrationPageState();
}

class _ServiceRegistrationPageState
    extends ModularState<ServiceRegistrationPage, ServiceBloc> {
  final ServiceCategoryBloc blocCategory = Modular.get<ServiceCategoryBloc>();
  String hourServiceTime = '0';
  String minServiceTime = '00';
  String hourWaitingTime = '0';
  String minWaitingTime = '00';
  String hourPostWaitTime = '0';
  String minPostWaitTime = '00';
  String name = '';
  bool haveWaiting = false;
  bool package = false;
  ServiceCategoryEntity? category;

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      int fullTimeService = (widget.entity!.serviceTime * 100).toInt();
      int fullTimePostWait = (widget.entity!.postWaitTime! * 100).toInt();
      int fullTimeWaiting = (widget.entity!.waitingTime! * 100).toInt();
      name = widget.entity!.name;
      haveWaiting = widget.entity!.haveWaiting;
      package = widget.entity!.package;
      if (fullTimeService >= 100) {
        hourServiceTime = fullTimeService
            .toString()
            .substring(0, fullTimeService.toString().length - 2);
        minServiceTime = fullTimeService
            .toString()
            .substring(fullTimeService.toString().length - 2);
      } else {
        hourServiceTime = '0';
        minServiceTime =
            fullTimeService == 0 ? '00' : fullTimeService.toString();
      }

      if (fullTimeWaiting >= 100) {
        hourWaitingTime = fullTimeWaiting
            .toString()
            .substring(0, fullTimeWaiting.toString().length - 2);
        minWaitingTime = fullTimeWaiting
            .toString()
            .substring(fullTimeWaiting.toString().length - 2);
      } else {
        hourWaitingTime = '0';
        minWaitingTime =
            fullTimeWaiting == 0 ? '00' : fullTimeWaiting.toString();
      }

      if (fullTimePostWait >= 100) {
        hourPostWaitTime = fullTimePostWait
            .toString()
            .substring(0, fullTimePostWait.toString().length - 2);
        minPostWaitTime = fullTimePostWait
            .toString()
            .substring(fullTimePostWait.toString().length - 2);
      } else {
        hourPostWaitTime = '0';
        minPostWaitTime =
            fullTimePostWait == 0 ? '00' : fullTimePostWait.toString();
      }
    }
    bloc.stream.listen((state) {
      if (state is ServiceStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
      }
      if (state is ServiceStateSaved) {
        Modular.to.navigate('/service/');
      }
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      blocCategory.add(const ServiceCategoryFetchList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceBloc, ServiceState>(
        bloc: bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cadastro de Categorias de Serviços',
                  textScaleFactor: 3.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    const Text(
                      'Serviço: ',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (text) {
                          name = text;
                        },
                        controller: TextEditingController(text: name),
                        validator: (name) {
                          if (name!.isEmpty) {
                            return 'Campo obrigatório!';
                          }
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Categoria: ',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<ServiceCategoryBloc,
                              ServiceCategoryState>(
                          bloc: blocCategory,
                          builder: (context, state) {
                            if (state is ServiceCategoryStateLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (state is ServiceCategoryStateSuccess) {
                              if (state.listServiceCategoryEntity.isEmpty) {
                                return const Text(
                                    'Favor cadastrar uma categoria');
                              } else {
                                if (widget.entity != null) {
                                  for (var item
                                      in state.listServiceCategoryEntity) {
                                    if (item.id == widget.entity!.category) {
                                      category = item;
                                    }
                                  }
                                }
                                return DropdownButton<ServiceCategoryEntity>(
                                  value: category,
                                  isExpanded: true,
                                  hint: const Text('Selecione a categoria'),
                                  icon:
                                      const Icon(Icons.arrow_drop_down_rounded),
                                  onChanged: (value) {
                                    setState(() {
                                      category = value!;
                                    });
                                  },
                                  items: state.listServiceCategoryEntity.map<
                                          DropdownMenuItem<
                                              ServiceCategoryEntity>>(
                                      (ServiceCategoryEntity value) {
                                    return DropdownMenuItem<
                                        ServiceCategoryEntity>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                );
                              }
                            }
                            return Container();
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Média de tempo do serviço: ',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        const Text('Horas'),
                        DropdownButton<String>(
                          value: hourServiceTime,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          onChanged: (value) {
                            setState(() {
                              hourServiceTime = value!;
                            });
                          },
                          items: <String>[
                            '0',
                            '1',
                            '2',
                            '3',
                            '4',
                            '5',
                            '6',
                            '7',
                            '8',
                            '9',
                            '10',
                            '11',
                            '12'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: [
                        const Text('Minutos'),
                        DropdownButton<String>(
                          value: minServiceTime,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          onChanged: (value) {
                            setState(() {
                              minServiceTime = value!;
                            });
                          },
                          items: <String>['00', '10', '20', '30', '40', '50']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Possui tempo de espera: ',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: CheckboxListTile(
                          title: const Text('Não'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Theme.of(context).colorScheme.primary,
                          checkColor: Colors.white,
                          value: !haveWaiting,
                          onChanged: (value) {
                            setState(() {
                              haveWaiting = !value!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: CheckboxListTile(
                          title: const Text('Sim'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Theme.of(context).colorScheme.primary,
                          checkColor: Colors.white,
                          value: haveWaiting,
                          onChanged: (value) {
                            setState(() {
                              haveWaiting = value!;
                            });
                          }),
                    ),
                  ],
                ),
                haveWaiting
                    ? TimeWaiting(
                        hourPostWaitTime: hourPostWaitTime,
                        hourWaitingTime: hourWaitingTime,
                        minPostWaitTime: minPostWaitTime,
                        minWaitingTime: minWaitingTime,
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'É um pacote: ',
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: CheckboxListTile(
                          title: const Text('Não'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Theme.of(context).colorScheme.primary,
                          checkColor: Colors.white,
                          value: !package,
                          onChanged: (value) {
                            setState(() {
                              package = !value!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 120,
                      child: CheckboxListTile(
                          title: const Text('Sim'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Theme.of(context).colorScheme.primary,
                          checkColor: Colors.white,
                          value: package,
                          onChanged: (value) {
                            setState(() {
                              package = value!;
                            });
                          }),
                    ),
                  ],
                ),
                package ? const Text('Em breve!') : Container(),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (name == '' && category != null) {
                            if (widget.entity == null) {
                              try {
                                ServiceEntity entity = ServiceEntity(
                                  name: name,
                                  category: category!.id!,
                                  package: package,
                                  serviceTime: double.parse(
                                      hourServiceTime + '.' + minServiceTime),
                                  haveWaiting: haveWaiting,
                                  postWaitTime: double.parse(
                                      hourPostWaitTime + '.' + minPostWaitTime),
                                  waitingTime: double.parse(
                                      hourWaitingTime + '.' + minWaitingTime),
                                );

                                bloc.add(ServiceInsert(entity));
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                          title: Text(
                                              'Erro ao inserir o serviço!'),
                                        ));
                              }
                            } else {
                              try {
                                ServiceEntity _service = ServiceEntity(
                                  id: widget.entity?.id,
                                  name: name,
                                  category: category!.id!,
                                  package: package,
                                  serviceTime: double.parse(
                                      hourServiceTime + '.' + minServiceTime),
                                  haveWaiting: haveWaiting,
                                  postWaitTime: double.parse(
                                      hourPostWaitTime + '.' + minPostWaitTime),
                                  waitingTime: double.parse(
                                      hourWaitingTime + '.' + minWaitingTime),
                                );

                                bloc.add(ServiceUpdate(_service));
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                          title:
                                              Text('Erro ao editar o serviço!'),
                                        ));
                              }
                            }
                          } else if (category == null) {
                            showDialog(
                                context: context,
                                builder: (_) => const AlertDialog(
                                      title: Text('Selecione uma categoria!'),
                                    ));
                          }
                        },
                        child: state is ServiceStateLoading
                            ? const CircularProgressIndicator(
                                color: Color.fromRGBO(97, 97, 97, 1),
                              )
                            : const Text(
                                'Salvar',
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
                          Modular.to.navigate('/service/');
                        },
                        child: const Text(
                          'Cancelar',
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
                  ),
                )
              ],
            ),
          );
        });
  }
}
