import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/lista_pedidos.dart';


class PedidoConsulta extends StatefulWidget {
  const PedidoConsulta({super.key});

  @override
  State<PedidoConsulta> createState() => _PedidoConsultaState();
}

class _PedidoConsultaState extends State<PedidoConsulta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta Pedidos'),      
      ),
      body: ListaPedidos(),
    );
  }
}