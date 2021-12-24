import 'package:beauty_salon_appointment_web/app/modules/home/presentation/ui/widgets/menu.dart';
import 'package:beauty_salon_appointment_web/app/modules/service_category/presentation/widgets/content_service_category.dart';
import 'package:flutter/material.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  _ServiceCategoryPageState createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState extends State<ServiceCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth < 600){
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
                elevation: 0,
              ),
              drawer: Drawer(
                shape: CircleBorder(),
                child: MenuWidget(),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              body: ContentServiceCategory(),
            );
          }else{
            return Scaffold(
                body: Row(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: MenuWidget()
                    ),
                    Expanded(
                      child: ContentServiceCategory(),
                    )
                  ],
                )
            );
          }
        }
    );
  }
}
