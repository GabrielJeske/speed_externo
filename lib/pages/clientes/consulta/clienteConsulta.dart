import 'package:flutter/material.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pf.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pj.dart';


class ClienteConsulta extends StatelessWidget {
  const ClienteConsulta({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Consulta de Clientes'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pessoa Física'),
              Tab(text: 'Pessoa Jurídica'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConsultaPf(),
            ConsultaPj(),
          ],
        ),
      ),
    );
  }
 }