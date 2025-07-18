import 'package:flutter/material.dart';
import 'package:speed_externo/pages/clientes/cadastro/cadastro_pf.dart';
import 'package:speed_externo/pages/clientes/cadastro/cadastro_pj.dart';


class clienteCadastro extends StatelessWidget {

  const clienteCadastro({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Clientes'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pessoa Física'),
              Tab(text: 'Pessoa Jurídica'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CadastroPF(),
            CadastroPJ(),
          ],
        ),
      ),
    );
  }
 }