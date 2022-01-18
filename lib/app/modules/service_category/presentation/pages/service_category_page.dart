import 'package:beauty_salon_appointment_web/app/modules/service_category/domain/entities/service_category_entity.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_bloc.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_event.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/bloc/service_category_state.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/widgets/card_service_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryPageState createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState
    extends ModularState<ServiceCategoryPage, ServiceCategoryBloc> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      bloc.add(const ServiceCategoryFetchList());
    });

    bloc.stream.listen((state) {
      if (state is ServiceCategoryStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
        ));
        bloc.add(const ServiceCategoryFetchList());
      }
      if(state is ServiceCategoryStateDeleted){
        showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              title: Text(
                  'Categoria removida com sucesso!'),
            ));
        bloc.add(const ServiceCategoryFetchList());
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
              'Categorias de Serviços',
              textScaleFactor: 3.5,
              style: TextStyle(fontWeight: FontWeight.bold),
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
            BlocBuilder<ServiceCategoryBloc, ServiceCategoryState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is ServiceCategoryStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ServiceCategoryStateSuccess) {
                    if (state.listServiceCategoryEntity.isEmpty) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                      );
                    } else {
                      List<ServiceCategoryEntity> listCategory =
                          state.listServiceCategoryEntity;
                      return LayoutBuilder(builder: (context, constraints) {
                        if (constraints.maxWidth < 900) {
                          return ListView.builder(
                              itemCount: listCategory.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                ServiceCategoryEntity category =
                                    listCategory[i];
                                return CardServiceCategory(
                                  category: category,
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
                              itemCount: listCategory.length,
                              itemBuilder: (context, i) {
                                ServiceCategoryEntity category =
                                    listCategory[i];
                                return CardServiceCategory(
                                  category: category,
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
                    'Nova Categoria',
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
