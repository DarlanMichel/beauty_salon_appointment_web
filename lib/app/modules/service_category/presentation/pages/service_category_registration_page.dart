import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:beauty_salon_appointment_web/app/shared/cloudinary_public.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class ServiceCategoryRegistrationPage extends StatefulWidget {
  final ServiceCategoryEntity? entity;
  const ServiceCategoryRegistrationPage({Key? key, @Data this.entity})
      : super(key: key);

  @override
  _ServiceCategoryRegistrationPageState createState() =>
      _ServiceCategoryRegistrationPageState();
}

class _ServiceCategoryRegistrationPageState
    extends ModularState<ServiceCategoryRegistrationPage, ServiceCategoryBloc> {
  static final formKey = GlobalKey<FormState>();
  PickedFile? image;
  var imageMemory;
  var picture;
  String name = '';

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      picture = widget.entity?.picture;
      name = widget.entity!.name;
    }

    bloc.stream.listen((state) {
      if (state is ServiceCategoryStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
      }
      if (state is ServiceCategoryStateSaved) {
        Modular.to.navigate('/serviceCategory/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServiceCategoryBloc, ServiceCategoryState>(
        bloc: bloc,
        builder: (context, state) {
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
                                      : Image.memory(
                                          imageMemory,
                                          height: 90,
                                          width: 90,
                                        ))),
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
                          'Fazer upload da imagem',
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate() &&
                                (imageMemory != null ||
                                    widget.entity?.picture != null)) {
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
                                  bloc.add(ServiceCategoryInsert(
                                      name: name, picture: picture!));
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
                                                'Erro ao inserir a categoria!'),
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

                                  ServiceCategoryEntity _serviceCategory =
                                      ServiceCategoryEntity(
                                          id: widget.entity!.id,
                                          name: name,
                                          picture: picture!);

                                  bloc.add(
                                      ServiceCategoryUpdate(_serviceCategory));
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
                                                'Erro ao editar a categoria!'),
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
                            Modular.to.navigate('/serviceCategory/');
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
