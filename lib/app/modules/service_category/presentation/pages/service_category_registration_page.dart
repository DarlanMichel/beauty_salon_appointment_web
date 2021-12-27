import 'dart:html';
import 'dart:typed_data';

import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceCategoryRegistrationPage extends StatefulWidget {
  const ServiceCategoryRegistrationPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryRegistrationPageState createState() =>
      _ServiceCategoryRegistrationPageState();
}

class _ServiceCategoryRegistrationPageState extends ModularState<
    ServiceCategoryRegistrationPage, ServiceCategoryController> {

  Uint8List? image;

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
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: CircleAvatar(
                      radius: 70,
                      backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                      child: image == null
                      ? Container()
                      : Image.memory(image!))),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? picked = await FilePicker.platform
                      .pickFiles(type: FileType.image, allowMultiple: false);
                  if (picked != null) {
                    setState(() {
                      image = picked.files.single.bytes;
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
                child: Container(
                  child: TextFormField(),
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
                  onPressed: () {},
                  child: const Text(
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
          )
        ],
      ),
    );
  }
}
