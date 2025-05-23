import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
       child: Column( 
              children: [
                SizedBox(height: 25),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Inicio'),
                   onTap: () {
                        Get.toNamed('/');
                      },
                ),
                ExpansionTile(title: Text('Clientes'),
                leading: Icon(Icons.person),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add) ,
                      title: Text('Cadastro'), 
                      onTap: () {
                        Get.toNamed('/cliente/cadastro');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Consulta'),  
                      onTap: () {
                        Get.toNamed('/cliente/consulta');
                      },
                    ),                                
                  ],
                ),
                ExpansionTile(title: Text('Produtos'),
                leading: Icon(Icons.shopping_bag_outlined),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add) ,
                      title: Text('Cadastro'),  
                      onTap: () {
                        Get.toNamed('/produto/cadastro');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Consulta'),
                       onTap: () {
                        Get.toNamed('/produto/consulta');
                      },  
                    ),                            
                  ],
                ),
                ExpansionTile(title: Text('Pedidos'),
                leading: Icon(Icons.shopping_cart),
                  children: [
                    ListTile(
                      leading: Icon(Icons.add) ,
                      title: Text('Inclusão'),  
                    ),
                    ListTile(
                      leading: Icon(Icons.search),
                      title: Text('Consulta'),  
                    ),
                  ],
                ),
                Expanded(child: Container()),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configuracoes'),
                  onTap: () {
                        Get.toNamed('/config');
                      },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sair'),
                )
              ],
        ),
      );
  }
}