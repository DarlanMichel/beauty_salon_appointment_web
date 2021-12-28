import 'package:beauty_salon_appointment_web/app/modules/home/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth < 900){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
              elevation: 0,
            ),
            drawer: Drawer(
              shape: const CircleBorder(),
              child: const MenuWidget(),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: RouterOutlet(),
          );
        }else{
          return Scaffold(
              body: Row(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: MenuWidget()
                  ),
                  Expanded(
                    child: RouterOutlet(),
                  )
                ],
              )
          );
        }
      }
    );
  }
}