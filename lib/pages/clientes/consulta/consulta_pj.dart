// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/cliente_pj_form.dart';

class ConsultaPj extends StatelessWidget {

  const ConsultaPj({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientePjForm(isConsulta: true,),
    );
  }
}
