import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/produto_form.dart';

class ConsultaProd extends StatelessWidget {

  const ConsultaProd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de Produtos'),
      ),
      body: ProdutoForm(isConsulta: true,),
    );
  }
}
