
import 'package:get/get.dart';
import 'package:speed_externo/pages/clienteCadastro.dart';
import 'package:speed_externo/pages/clienteConsulta.dart';
import 'package:speed_externo/pages/cofig_page.dart';
import 'package:speed_externo/pages/home_page.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/cliente/cadastro', page: () => clienteCadastro()),
    GetPage(name: '/cliente/consulta', page: () => ClienteConsulta()),
    GetPage(name: '/config', page: () => ConfigPage()),
    
  ];

}