import 'package:flutter/material.dart';
import 'package:speed_externo/commom/widgets/custom_appbar.dart';
import 'package:speed_externo/commom/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppBar(title: 'Home'),
      drawer: CustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text('SpeedExterno')
          )          
        ],
      ),
    );
  }
}