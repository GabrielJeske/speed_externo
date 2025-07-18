import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/commom/objetos/conta.dart';
import 'package:speed_externo/commom/objetos/faturamento.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'commom/styles/theme.dart';
import 'package:speed_externo/routes.dart';
import 'package:speed_externo/funcoes/autentica.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/produto_controller.dart';
import 'package:speed_externo/stores/config_store.dart';
import 'package:speed_externo/stores/produto_dados.dart';
import 'package:speed_externo/stores/pedido_dados.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/cliente_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/funcoes/validate.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  
  await Hive.initFlutter(dir.path);


  Hive.registerAdapter(ClienteAdapter());
  await Hive.openBox<Cliente>('Clientes');

  Hive.registerAdapter(PedidoAdapter());
  await Hive.openBox<Pedido>('Pedidos');
  
  Hive.registerAdapter(FaturamentoAdapter());
  await Hive.openBox<Faturamento>('Faturamentos');

  Hive.registerAdapter(ContaAdapter());
  await Hive.openBox<Conta>('Contas');


  Hive.registerAdapter(ProdutoAdapter());
  await Hive.openBox<Produto>('Produtos');

  Get.put(Autentica());
  Get.put(FaturamentoController());
  Get.put(Validate());
  Get.put(ClienteController());
  Get.put(ProdutoFormStore());
  Get.put(DadosProdutoStore());
  Get.put(ClienteDados());
  Get.put(ConfigStore());
  Get.put(PedidoStore());
  Get.put(DadosPedidoStore());
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Get.find<ConfigStore>();
    final materialTheme = MaterialTheme(Theme.of(context).textTheme);
    return Observer(builder: (_) => 
    GetMaterialApp(
      title: 'SpeedExterno',      
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: config.themeMode,
      initialRoute: '/login',
      getPages: Routes.routes
    )
    );
  }
}