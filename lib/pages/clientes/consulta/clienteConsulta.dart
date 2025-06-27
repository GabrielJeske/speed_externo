import 'package:flutter/material.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pf.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pj.dart';

class Clienteconsulta extends StatefulWidget {
  const Clienteconsulta({super.key});

  @override
  State<Clienteconsulta> createState() => _ClienteconsultaState();
}

class _ClienteconsultaState extends State<Clienteconsulta> {
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