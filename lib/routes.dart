
import 'package:get/get.dart';
import 'package:speed_externo/pages/cliente_page.dart';
import 'package:speed_externo/pages/cofig_page.dart';
import 'package:speed_externo/pages/home_page.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/cliente/consulta', page: () => ClientePage()),
    GetPage(name: '/config', page: () => ConfigPage()),
    
  ];

}