import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:beauty_salon_appointment_web/app/shared/cloudinary_public.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';

class ServiceCategoryRegistrationPage extends StatefulWidget {
  final ServiceCategoryEntity? entity;
  const ServiceCategoryRegistrationPage({Key? key, this.entity})
      : super(key: key);

  @override
  _ServiceCategoryRegistrationPageState createState() =>
      _ServiceCategoryRegistrationPageState();
}

class _ServiceCategoryRegistrationPageState extends ModularState<
    ServiceCategoryRegistrationPage, ServiceCategoryController> {
  PickedFile? image;
  var imageMemory;

  @override
  void initState() {
    super.initState();
    if (widget.entity != null) {
      controller.setName(widget.entity!.name);
      controller.setPicture(widget.entity!.picture);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                      child: controller.picture != null
                          ? Image.network(
                              controller.picture!,
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
                      controller.setPicture(null);
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
                  onChanged: controller.setName,
                  controller: TextEditingController(text: controller.name),
                ),
              )
            ],
          ),
          Expanded(child: Container()),
          Observer(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      controller.setLoading(true);
                      final cloudinary = CustomCloudinary.getCloudinary();
                      if (widget.entity == null) {
                        try {
                          CloudinaryResponse response = await cloudinary
                              .uploadFile(CloudinaryFile.fromFile(image!.path,
                                  resourceType: CloudinaryResourceType.Image));
                          controller.setPicture(response.secureUrl);
                          var entity = await controller.saveServiceCategory(
                              name: controller.name!,
                              picture: controller.picture!);
                          if (entity.id != null) {
                            Modular.to.navigate('/serviceCategory/');
                          }
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
                                    title: Text('Erro ao inserir a categoria!'),
                                  ));
                        }
                      } else {
                        try {
                          if (imageMemory != null) {
                            CloudinaryResponse response = await cloudinary
                                .uploadFile(CloudinaryFile.fromFile(image!.path,
                                    resourceType:
                                        CloudinaryResourceType.Image));
                            controller.setPicture(response.secureUrl);
                          }

                          ServiceCategoryEntity _serviceCategory =
                              ServiceCategoryEntity(
                                  id: widget.entity!.id,
                                  name: controller.name!,
                                  picture: controller.picture!);

                          var updatedEntity = await controller
                              .updateServiceCategory(_serviceCategory);
                          if (updatedEntity.id != null) {
                            Modular.to.navigate('/serviceCategory/');
                          }
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
                                    title: Text('Erro ao editar a categoria!'),
                                  ));
                        }
                      }
                      controller.setLoading(false);
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
                      Modular.to.navigate('/serviceCategory/');
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
            );
          })
        ],
      ),
    );
  }
}
