import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/styles/thema_app.dart';
import 'package:speed_externo/routes.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/produto_controller.dart';
import 'package:speed_externo/stores/config_store.dart';
import 'package:speed_externo/stores/produto_dados.dart';
import 'package:speed_externo/stores/pedido_dados.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/cliente_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/stores/validate_store.dart';


void main (){
  Get.put(FaturamentoController());
  Get.put(ValidateStore());
  Get.put(FormStore());
  Get.put(ProdutoFormStore());
  Get.put(DadosProdutoStore());
  Get.put(DadosStore());
  Get.put(ConfigStore());
  Get.put(PedidoStore());
  Get.put(DadosPedidoStore());
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Get.find<ConfigStore>();
    return Observer(builder: (_) =>
    GetMaterialApp(
      theme: lightTheme, // Use os temas definidos
      darkTheme: darkTheme,
      themeMode: config.themeMode,
      initialRoute: '/',
      getPages: Routes.routes,
    )
    );
  }
}