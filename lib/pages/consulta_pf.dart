import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/forms/cliente_pf_form.dart';
import 'package:speed_externo/stores/form_store.dart';
import 'dart:developer' as developer; // Import para log

class ConsultaPf extends StatefulWidget {
  const ConsultaPf({Key? key}) : super(key: key);

  @override
  _ConsultaPfState createState() => _ConsultaPfState();
}

class _ConsultaPfState extends State<ConsultaPf> {
  final formStore = Get.find<FormStore>();
 
  @override
  void initState() {
    super.initState();
    formStore.clientStream.listen((data) {
      developer.log('ConsultaPf: Stream emitindo: $data');
    }, onError: (error) {
      developer.log('ConsultaPf: Erro no Stream: $error');
    }, onDone: () {
      developer.log('ConsultaPf: Stream concluído');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClientePfForm(
        isConsulta: true,
        clientStream: formStore.clientStream,
      ),
    );
  }
}