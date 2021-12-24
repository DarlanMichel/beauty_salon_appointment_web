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
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )
      ),
      child: Column(
        children: [
          Padding(
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
          ListTile(
            textColor: Colors.white,
            title: Text('Categorias de Serviços',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            //selectedColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){
              Modular.to.navigate('/serviceCategory');
            },
          ),
          ListTile(
            textColor: Colors.white,
            title: Text('Colaboradores',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){},
          ),
          ListTile(
            textColor: Colors.white,
            title: Text('Comissões',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){},
          ),
          ListTile(
            textColor: Colors.white,
            title: Text('Manutenção da Agenda',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){},
          ),
          ListTile(
            textColor: Colors.white,
            title: Text('Serviços',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){},
          ),
          ListTile(
            textColor: Colors.white,
            title: Text('Solicitações de Perfis',
              textScaleFactor: 1.3,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
              ),),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            onTap: (){},
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Logout',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Versão 1.0.0',
                    textScaleFactor: 1.3,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                )
              ],
            ),
          )

        ],
      ),
    );
  }
}
