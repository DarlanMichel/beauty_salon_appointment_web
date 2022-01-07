import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/controllers/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceRegistrationPage extends StatefulWidget {
  final ServiceEntity? entity;
  const ServiceRegistrationPage({Key? key, this.entity}) : super(key: key);

  @override
  _ServiceRegistrationPageState createState() =>
      _ServiceRegistrationPageState();
}

class _ServiceRegistrationPageState
    extends ModularState<ServiceRegistrationPage, ServiceController> {
  static final formKey = GlobalKey<FormState>();
  String hourServiceTime = '0';
  String minServiceTime = '00';
  String hourWaitingTime = '0';
  String minWaitingTime = '00';
  String hourPostWaitTime = '0';
  String minPostWaitTime = '00';

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      int fullTimeService = (widget.entity!.serviceTime * 100).toInt();
      int fullTimePostWait = (widget.entity!.postWaitTime! * 100).toInt();
      int fullTimeWaiting = (widget.entity!.waitingTime! * 100).toInt();
      controller.setName(widget.entity!.name);
      for (var item in controller.listCategoryEntity!) {
        if (item.id == widget.entity!.category) {
          controller.setCategory(item);
        }
      }
      controller.setHaveWaiting(widget.entity!.haveWaiting);
      controller.setPackage(widget.entity!.package);
      if (fullTimeService >= 100) {
        hourServiceTime = fullTimeService
            .toString()
            .substring(0, fullTimeService.toString().length - 2);
        minServiceTime = fullTimeService
            .toString()
            .substring(fullTimeService.toString().length - 2);
      }else{
        hourServiceTime = '0';
        minServiceTime = fullTimeService.toString();
      }

      if( fullTimeWaiting >= 100){
        hourWaitingTime =fullTimeWaiting
            .toString()
            .substring(0, fullTimeWaiting.toString().length - 2);
        minWaitingTime = fullTimeWaiting
            .toString()
            .substring(fullTimeWaiting.toString().length - 2);
      }else{
        hourWaitingTime = '0';
        minWaitingTime = fullTimeWaiting.toString();
      }

      if(fullTimePostWait >= 100){
        hourPostWaitTime = fullTimePostWait
            .toString()
            .substring(0, fullTimePostWait.toString().length - 2);
        minPostWaitTime = fullTimePostWait
            .toString()
            .substring(fullTimePostWait.toString().length - 2);
      }else{
        hourPostWaitTime = '0';
        minPostWaitTime = fullTimePostWait.toString();
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if(controller.listCategoryEntity == null){
        return Center(child: CircularProgressIndicator(),);
      }
      return Padding(
        padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
        child: Form(
          key: formKey,
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
                      onChanged: controller.setName,
                      controller: TextEditingController(text: controller.name),
                      validator: (servico) {
                        if (servico!.isEmpty) {
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
                    child: DropdownButton<ServiceCategoryEntity>(
                      value: controller.category,
                      isExpanded: true,
                      hint: const Text('Selecione a categoria'),
                      icon: const Icon(Icons.arrow_drop_down_rounded),
                      onChanged: (value) {
                        setState(() {
                          controller.setCategory(value!);
                        });
                      },
                      items: controller.listCategoryEntity!
                          .map<DropdownMenuItem<ServiceCategoryEntity>>(
                              (ServiceCategoryEntity value) {
                        return DropdownMenuItem<ServiceCategoryEntity>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
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
                        value: !controller.haveWaiting,
                        onChanged: (value) {
                          setState(() {
                            controller.setHaveWaiting(!value!);
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
                        value: controller.haveWaiting,
                        onChanged: (value) {
                          setState(() {
                            controller.setHaveWaiting(value!);
                          });
                        }),
                  ),
                ],
              ),
              controller.haveWaiting
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Média de tempo de espera: ',
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
                                value: hourWaitingTime,
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                onChanged: (value) {
                                  setState(() {
                                    hourWaitingTime = value!;
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
                                value: minWaitingTime,
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                onChanged: (value) {
                                  setState(() {
                                    minWaitingTime = value!;
                                  });
                                },
                                items: <String>[
                                  '00',
                                  '10',
                                  '20',
                                  '30',
                                  '40',
                                  '50'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                    )
                  : Container(),
              controller.haveWaiting
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          const Text(
                            'Média de tempo pós espera: ',
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
                                value: hourPostWaitTime,
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                onChanged: (value) {
                                  setState(() {
                                    hourPostWaitTime = value!;
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
                                value: minPostWaitTime,
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                onChanged: (value) {
                                  setState(() {
                                    minPostWaitTime = value!;
                                  });
                                },
                                items: <String>[
                                  '00',
                                  '10',
                                  '20',
                                  '30',
                                  '40',
                                  '50'
                                ].map<DropdownMenuItem<String>>((String value) {
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
                        value: !controller.package,
                        onChanged: (value) {
                          setState(() {
                            controller.setPackage(!value!);
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
                        value: controller.package,
                        onChanged: (value) {
                          setState(() {
                            controller.setPackage(value!);
                          });
                        }),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          controller.setLoading(true);
                          if (widget.entity == null) {
                            try {
                              ServiceEntity entity = ServiceEntity(
                                name: controller.name!,
                                category: controller.category!.id!,
                                package: controller.package,
                                serviceTime: double.parse(
                                    hourServiceTime + '.' + minServiceTime),
                                haveWaiting: controller.haveWaiting,
                                postWaitTime: double.parse(
                                    hourPostWaitTime + '.' + minPostWaitTime),
                                waitingTime: double.parse(
                                    hourWaitingTime + '.' + minWaitingTime),
                              );

                              var response =
                                  await controller.saveService(entity);

                              if (response.id != null) {
                                Modular.to.navigate('/service/');
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                        title:
                                            Text('Erro ao inserir o serviço!'),
                                      ));
                            }
                          } else {
                            try {
                              ServiceEntity _service = ServiceEntity(
                                id: widget.entity?.id,
                                name: controller.name!,
                                category: controller.category!.id!,
                                package: controller.package,
                                serviceTime: double.parse(
                                    hourServiceTime + '.' + minServiceTime),
                                haveWaiting: controller.haveWaiting,
                                postWaitTime: double.parse(
                                    hourPostWaitTime + '.' + minPostWaitTime),
                                waitingTime: double.parse(
                                    hourWaitingTime + '.' + minWaitingTime),
                              );

                              var updatedEntity =
                                  await controller.updateService(_service);
                              if (updatedEntity.id != null) {
                                Modular.to.navigate('/service/');
                              }
                            } catch (e) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                        title:
                                            Text('Erro ao editar o serviço!'),
                                      ));
                            }
                          }
                          controller.setLoading(false);
                        }
                      },
                      child: controller.isLoading
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
        ),
      );
    });
  }
}
