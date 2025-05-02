import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/widgets/custom_appbar.dart';
import 'package:speed_externo/commom/widgets/custom_drawer.dart';
import 'package:speed_externo/stores/config_store.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = Get.find<ConfigStore>();
    return Scaffold(
      
      appBar: CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [        
          Align(
            alignment: Alignment.center,
            child: Observer(builder: (_) =>
              Switch(
                value: config.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  config.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              )  
            ),
          )
        ],
      ),
    );
  }
}

