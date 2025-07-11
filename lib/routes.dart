
import 'package:get/get.dart';
import 'package:speed_externo/pages/clientes/cadastro/clienteCadastro.dart';
import 'package:speed_externo/pages/clientes/consulta/clienteConsulta.dart';
import 'package:speed_externo/pages/cofig_page.dart';
import 'package:speed_externo/pages/home_page.dart';
import 'package:speed_externo/pages/login.dart';
import 'package:speed_externo/pages/pedidos/pedido.dart';
import 'package:speed_externo/pages/pedidos/pedido_consulta.dart';
import 'package:speed_externo/pages/produtos/cadastro/prodCadastro.dart';
import 'package:speed_externo/pages/produtos/consulta/prodConsulta.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/cliente/cadastro', page: () => clienteCadastro()),
    GetPage(name: '/cliente/consulta', page: () => Clienteconsulta()),
    GetPage(name: '/produto/cadastro', page: () => CadastroProd()),
    GetPage(name: '/produto/consulta', page: () => ConsultaProd()),
    GetPage(name: '/pedido/inclusao', page: () => Pedido()),
    GetPage(name: '/pedido/consulta', page: () => PedidoConsulta()),
    GetPage(name: '/config', page: () => ConfigPage()),
    
  ];

}