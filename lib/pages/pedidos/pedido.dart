import 'package:flutter/material.dart';
import 'package:speed_externo/commom/forms/pedido_form.dart';

class Pedido extends StatefulWidget {
  const Pedido({super.key});

  @override
  State<Pedido> createState() => _PedidoState();
}

class _PedidoState extends State<Pedido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inclusao Pedido'),      
      ),
      body: PedidoForm(),
    );
  }
}