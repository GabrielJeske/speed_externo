import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/styles/thema_app.dart';
import 'package:speed_externo/routes.dart';
import 'package:speed_externo/stores/config_store.dart';
import 'package:speed_externo/stores/form_store.dart';


void main (){
  Get.put(FormStore());
  Get.put(ConfigStore());
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