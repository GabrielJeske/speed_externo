import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/produto_form.dart';

class CadastroProd extends StatelessWidget {

  const CadastroProd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtos'),
      ),
      body: ProdutoForm(),
    );
  }
}
