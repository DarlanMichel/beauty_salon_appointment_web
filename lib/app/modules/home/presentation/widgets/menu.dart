import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: NavigationListener(builder: (context, widget) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(75),
              child: Text(
                'Beauty Salon',
                textScaleFactor: 3.6,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/serviceCategory/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Categorias de Serviços',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/serviceCategory/'),
                selectedColor: Colors.black,
                onTap: () {
                  Modular.to.navigate('/serviceCategory/');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/collaborator/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Colaboradores',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/collaborator/'),
                selectedColor: Colors.black,
                onTap: () {
                  Modular.to.navigate('/collaborator/');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/commission/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Comissões',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/commission/'),
                selectedColor: Colors.black,
                onTap: () {},
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/maintenanceSchedule/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Manutenção da Agenda',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/maintenanceSchedule/'),
                selectedColor: Colors.black,
                onTap: () {},
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/service/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Serviços',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/service/'),
                selectedColor: Colors.black,
                onTap: () {
                  Modular.to.navigate('/service/');
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Modular.to.path.contains('/requestProfiles/')
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              child: ListTile(
                textColor: Colors.white,
                title: const Text(
                  'Solicitações de Perfis',
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                selected: Modular.to.path.contains('/requestProfiles/'),
                selectedColor: Colors.black,
                onTap: () {},
              ),
            ),
            Expanded(child: Container()),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Logout',
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Versão 1.0.0',
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
