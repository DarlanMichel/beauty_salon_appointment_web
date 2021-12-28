import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/controllers/service_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CardServiceCategory extends StatelessWidget {
  final ServiceCategoryEntity category;
  const CardServiceCategory({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceCategoryController controller =
        Modular.get<ServiceCategoryController>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
                  child: Image.network(
                    category.picture,
                    height: 90,
                    width: 90,
                  ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Categoria: ${category.name}',
                  textScaleFactor: 1.6,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate('./new', arguments: category);
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
                      onPressed: () async {
                        int deleted = await controller
                            .deleteServiceCategory(category.id!);
                        if (deleted == 1) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        'Categoria ${category.name} removida com sucesso!'),
                                  ));
                          await controller.getServiceCategory();
                        }
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
            )
          ],
        ),
      ),
    );
  }
}
