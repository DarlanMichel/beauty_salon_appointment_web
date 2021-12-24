import 'package:beauty_salon_appointment_web/app/modules/home/presentation/ui/widgets/content_home_page.dart';
import 'package:beauty_salon_appointment_web/app/modules/home/presentation/ui/widgets/menu.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
            body: ContentHomePage(),
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
                    child: ContentHomePage(),
                  )
                ],
              )
          );
        }
      }
    );
  }
}