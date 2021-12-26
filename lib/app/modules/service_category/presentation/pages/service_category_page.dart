import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryPageState createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState extends ModularState<ServiceCategoryPage, ServiceCategoryController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 70, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categorias de Serviços',
            textScaleFactor: 3.5,
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Faça o cadastro das categorias de serviços prestados pelo salão, para que seja apresentado na tela inicial do aplicativo',
            textScaleFactor: 1.3,
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            child: Observer(
                builder: (context) {
                  if(controller.listServiceCategoryEntity == null){
                    return const Center(child: CircularProgressIndicator(),);
                  } else{
                    List<ServiceCategoryEntity> listCategory = controller.listServiceCategoryEntity!;
                    if(listCategory.isEmpty){
                      return const Center(child: Text('Sem categorias cadastradas!'),);
                    }else{
                      return ListView.builder(
                          itemCount: listCategory.length,
                          itemBuilder: (context, i){
                            ServiceCategoryEntity category = listCategory[i];
                            return Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                                        child: Image.network(category.picture, height: 90, width: 90,),
                                      )
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Categoria: ${category.name}',
                                        textScaleFactor: 2,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            onPressed: (){},
                                            child: const Text(
                                              'Editar',
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(97, 97, 97, 1),
                                                  fontWeight: FontWeight.bold
                                              ),
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
                                            onPressed: (){},
                                            child: const Text(
                                              'Excluir',
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold
                                              ),
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
                            );
                          }
                      );
                    }
                  }
                }
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: (){},
              child: const Text(
                'Nova Categoria',
                textScaleFactor: 1.2,
                style: TextStyle(
                    color: Color.fromRGBO(97, 97, 97, 1),
                    fontWeight: FontWeight.bold
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                fixedSize: const Size(150, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
