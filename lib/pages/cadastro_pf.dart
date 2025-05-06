import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/cliente_pf_form.dart';

class CadastroPF extends StatelessWidget {
  const CadastroPF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientePfForm(),
    );
  }
}