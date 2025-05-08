// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:speed_externo/commom/forms/cliente_pf_form.dart';

class ConsultaPf extends StatelessWidget {

  const ConsultaPf({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientePfForm(isConsulta: true,),
    );
  }
}
