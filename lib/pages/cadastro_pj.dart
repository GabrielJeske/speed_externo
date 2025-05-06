import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/cliente_pj_form.dart';

class CadastroPJ extends StatelessWidget {
  const CadastroPJ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ClientePjForm(),
    );
  }
}