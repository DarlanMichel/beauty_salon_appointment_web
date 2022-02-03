import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_schedules_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/domain/entities/collaborator_services_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/bloc/collaborator_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/collaborator/presentation/widgets/shedule_tab_view.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/domain/entities/service_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/services/presentation/bloc/service_state.dart';
import 'package:beauty_salon_appointment_web/app/shared/cloudinary_public.dart';
import 'package:camera/camera.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class CollaboratorRegistrationPage extends StatefulWidget {
  final CollaboratorEntity? entity;
  const CollaboratorRegistrationPage({Key? key, @Data this.entity})
      : super(key: key);

  @override
  _CollaboratorRegistrationPageState createState() =>
      _CollaboratorRegistrationPageState();
}

class _CollaboratorRegistrationPageState
    extends ModularState<CollaboratorRegistrationPage, CollaboratorBloc> {
  final ServiceBloc blocService = Modular.get<ServiceBloc>();
  var image;
  var imageMemory;
  var picture;
  String name = '';
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool loading = false;
  String price = '';
  String percentage = '';
  ServiceEntity? serviceEntity;
  List<ServiceEntity> listServiceEntity = [];
  List<CollaboratorServicesEntity> listCollaboratorServices = [];
  List<CollaboratorSchedulesEntity> listCollaboratorSchedules = [];

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      picture = widget.entity?.picture;
      name = widget.entity!.name;
      if(widget.entity!.servicesProvided != null){
        listCollaboratorServices.addAll(widget.entity!.servicesProvided!);
      }
      if(widget.entity!.schedules != null){
        listCollaboratorSchedules.addAll(widget.entity!.schedules!);
      }
    }

    bloc.stream.listen((state) {
      if (state is CollaboratorStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
      }
      if (state is CollaboratorStateSaved) {
        Modular.to.navigate('/collaborator/');
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      blocService.add(const ServiceFetchList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollaboratorBloc, CollaboratorState>(
        bloc: bloc,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 50, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cadastro de Colaboradores',
                    textScaleFactor: 3.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    'Foto:',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: CircleAvatar(
                              radius: 70,
                              backgroundColor:
                                  const Color.fromRGBO(196, 196, 196, 1),
                              child: picture != null
                                  ? Image.network(
                                      picture!,
                                      height: 90,
                                      width: 90,
                                    )
                                  : imageMemory == null
                                      ? Container()
                                      : ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(70),
                                            child: Image.memory(
                                              imageMemory,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ))),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              image = await ImagePicker.platform
                                  .pickImage(source: ImageSource.gallery);
                              if (image != null) {
                                imageMemory = await image!.readAsBytes();
                                setState(() {
                                  picture = null;
                                });
                              }
                            },
                            child: const Text(
                              'Fazer upload do computador',
                              textScaleFactor: 1.2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary,
                              fixedSize: const Size(250, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              WidgetsFlutterBinding.ensureInitialized();
                              final cameras = await availableCameras();
                              final firstCamera = cameras.first;
                              _controller = CameraController(
                                firstCamera,
                                ResolutionPreset.ultraHigh,
                              );
                              _initializeControllerFuture =
                                  _controller.initialize();
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => Dialog(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.7,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: FutureBuilder<void>(
                                                    future:
                                                        _initializeControllerFuture,
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .done) {
                                                        return CameraPreview(
                                                            _controller);
                                                      } else {
                                                        return const CircularProgressIndicator();
                                                      }
                                                    }),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  await _initializeControllerFuture;
                                                  image =
                                                      await _controller
                                                          .takePicture();
                                                  imageMemory =
                                                      await image.readAsBytes();
                                                  setState(() {
                                                    loading = false;
                                                  });
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                child: const Icon(
                                                    Icons.camera_alt),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fixedSize: const Size(80, 40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: loading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Ativar câmera',
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary,
                              fixedSize: const Size(250, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Nome: ',
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
                  Container(
                    height: 165,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Serviços realizados: ',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          4.9,
                                      child: BlocBuilder<ServiceBloc,
                                              ServiceState>(
                                          bloc: blocService,
                                          builder: (context, state) {
                                            if (state is ServiceStateLoading) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                            if (state is ServiceStateSuccess) {
                                              listServiceEntity.addAll(
                                                  state.listServiceEntity);
                                              if (state
                                                  .listServiceEntity.isEmpty) {
                                                return const Text(
                                                    'Favor cadastrar um serviço');
                                              } else {
                                                return DropdownButton<
                                                    ServiceEntity>(
                                                  value: serviceEntity,
                                                  isExpanded: true,
                                                  hint: const Text(
                                                      'Selecione o serviço'),
                                                  icon: const Icon(Icons
                                                      .arrow_drop_down_rounded),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      serviceEntity = value!;
                                                    });
                                                  },
                                                  items: state.listServiceEntity
                                                      .map<
                                                              DropdownMenuItem<
                                                                  ServiceEntity>>(
                                                          (ServiceEntity
                                                              value) {
                                                    return DropdownMenuItem<
                                                        ServiceEntity>(
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Preço: ',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          10.2,
                                      child: TextFormField(
                                        onChanged: (text) {
                                          price = text;
                                        },
                                        controller:
                                            TextEditingController(text: price),
                                        validator: (price) {
                                          if (price!.isEmpty) {
                                            return 'Campo obrigatório!';
                                          }
                                        },
                                      ),
                                    ),
                                    const Text(
                                      'Porcentagem: ',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          10.2,
                                      child: TextFormField(
                                        onChanged: (text) {
                                          percentage = text;
                                        },
                                        controller: TextEditingController(
                                            text: percentage),
                                        validator: (percentage) {
                                          if (percentage!.isEmpty) {
                                            return 'Campo obrigatório!';
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (price != '' &&
                                    percentage != '' &&
                                    serviceEntity?.id != null) {
                                  CollaboratorServicesEntity service =
                                      CollaboratorServicesEntity(
                                          percentage: double.parse(percentage),
                                          price: double.parse(price),
                                          service: serviceEntity!.id!);
                                  setState(() {
                                    listCollaboratorServices.add(service);
                                  });
                                }
                              },
                              child: const Text(
                                'Confirmar',
                                textScaleFactor: 1.2,
                                style: TextStyle(
                                    color: Color.fromRGBO(97, 97, 97, 1),
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary:
                                    Theme.of(context).colorScheme.secondary,
                                fixedSize: const Size(110, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 35,
                          child: ListView.builder(
                              itemCount: listCollaboratorServices.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, i) {
                                CollaboratorServicesEntity service =
                                    listCollaboratorServices[i];
                                String nameService = '';
                                for (var item in listServiceEntity) {
                                  if (item.id == service.service) {
                                    nameService = item.name;
                                  }
                                }
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.grey),
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '$nameService ${service.percentage}% R\$${service.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              listCollaboratorServices
                                                  .remove(service);
                                            });
                                          },
                                          child: const Icon(
                                            Icons.close_rounded,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          'Horários da agenda: ',
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DefaultTabController(
                            length: 7,
                            child: SizedBox(
                              height: 200,
                              child: Scaffold(
                                appBar: TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  labelColor: Colors.black,
                                  indicatorColor:
                                      Theme.of(context).colorScheme.secondary,
                                  unselectedLabelColor: Colors.black,
                                  unselectedLabelStyle: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  tabs: const [
                                    Tab(
                                      text: 'Dom',
                                    ),
                                    Tab(
                                      text: 'Seg',
                                    ),
                                    Tab(
                                      text: 'Ter',
                                    ),
                                    Tab(
                                      text: 'Qua',
                                    ),
                                    Tab(
                                      text: 'Qui',
                                    ),
                                    Tab(
                                      text: 'Sex',
                                    ),
                                    Tab(
                                      text: 'Sab',
                                    ),
                                  ],
                                ),
                                body: TabBarView(
                                  children: [
                                    TabViewSchedule(
                                      week: 'Dom',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Seg',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Ter',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Qua',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Qui',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Sex',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                    TabViewSchedule(
                                      week: 'Sab',
                                      listSchedule: listCollaboratorSchedules,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (imageMemory != null ||
                                widget.entity?.picture != null) {
                              final cloudinary =
                                  CustomCloudinary.getCloudinary();
                              if (widget.entity == null) {
                                try {
                                  CloudinaryResponse response = await cloudinary
                                      .uploadFile(CloudinaryFile.fromFile(
                                          image!.path,
                                          resourceType:
                                              CloudinaryResourceType.Image));
                                  picture = response.secureUrl;

                                  CollaboratorEntity _collaborator =
                                      CollaboratorEntity(
                                    name: name,
                                    picture: picture!,
                                    schedules: listCollaboratorSchedules,
                                    servicesProvided: listCollaboratorServices,
                                  );
                                  bloc.add(CollaboratorInsert(_collaborator));
                                } on CloudinaryException catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text(e.message!),
                                          ));
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => const AlertDialog(
                                            title: Text(
                                                'Erro ao inserir colaborador!'),
                                          ));
                                }
                              } else {
                                try {
                                  if (imageMemory != null) {
                                    CloudinaryResponse response =
                                        await cloudinary.uploadFile(
                                            CloudinaryFile.fromFile(image!.path,
                                                resourceType:
                                                    CloudinaryResourceType
                                                        .Image));
                                    picture = response.secureUrl;
                                  }

                                  CollaboratorEntity _collaborator =
                                      CollaboratorEntity(
                                    id: widget.entity!.id,
                                    name: name,
                                    picture: picture!,
                                    schedules: listCollaboratorSchedules,
                                    servicesProvided: listCollaboratorServices,
                                  );

                                  bloc.add(CollaboratorUpdate(_collaborator));
                                } on CloudinaryException catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text(e.message!),
                                          ));
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (_) => const AlertDialog(
                                            title: Text(
                                                'Erro ao editar colaborador!'),
                                          ));
                                }
                              }
                            }
                          },
                          child: state is ServiceCategoryStateLoading
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
                            Modular.to.navigate('/collaborator/');
                          },
                          child: const Text(
                            'Cancelar',
                            textScaleFactor: 1.2,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
