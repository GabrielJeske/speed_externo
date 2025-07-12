// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pf.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pj.dart';
import 'package:get/get.dart'; // Para Get.find
import 'package:speed_externo/stores/cliente_dados.dart'; // Para dadosCliente
import 'package:speed_externo/commom/objetos/cliente.dart'; // Para a extensão DocumentValidation
import 'package:mobx/mobx.dart'; // Importe para usar autorun ou reaction

class Clienteconsulta extends StatefulWidget {
  final int rota; // Manter a rota para initialIndex na primeira carga

  Clienteconsulta({
    Key? key,
    this.rota = 0, // Default para 0 se não for fornecido
  }) : super(key: key);

  @override
  State<Clienteconsulta> createState() => _ClienteconsultaState();
}

class _ClienteconsultaState extends State<Clienteconsulta> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final dadosCliente = Get.find<ClienteDados>(); // Acessa o store de dados do cliente

  // Disposer para o autorun do MobX, necessário para gerenciar o ciclo de vida
  late ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    // Inicializa o TabController com o número de abas, o vsync e o índice inicial
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.rota);

    // Usa `autorun` do MobX para reagir a mudanças no cliente selecionado (`dadosCliente.clienSele`).
    // Sempre que `clienSele` mudar, esta função será executada.
    _disposer = autorun((_) {
      final selecionaCliente = dadosCliente.clienSele; // Acessa o cliente selecionado no store
      if (selecionaCliente != null && selecionaCliente.cnpj != null) {
        // Verifica o tipo de documento e muda para a aba correspondente
        if (selecionaCliente.cnpj!.isCpf) {
          if (_tabController.index != 0) { // Evita mudar se já estiver na aba correta
            _tabController.animateTo(0); // Mudar para a aba de Pessoa Física (índice 0)
          }
        } else if (selecionaCliente.cnpj!.isCnpj) {
          if (_tabController.index != 1) { // Evita mudar se já estiver na aba correta
            _tabController.animateTo(1); // Mudar para a aba de Pessoa Jurídica (índice 1)
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Descartar o TabController
    _disposer(); // Descartar o autorun do MobX para evitar vazamento de memória
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Clientes'),
        bottom: TabBar(
          controller: _tabController, // Associa o TabController à TabBar
          tabs: const [
            Tab(text: 'Pessoa Física'),
            Tab(text: 'Pessoa Jurídica'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController, // Associa o TabController à TabBarView
        children: const [
          ConsultaPf(), // Seus widgets de conteúdo para cada aba
          ConsultaPj(),
        ],
      ),
    );
  }
}