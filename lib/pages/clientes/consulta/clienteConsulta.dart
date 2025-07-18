// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pf.dart';
import 'package:speed_externo/pages/clientes/consulta/consulta_pj.dart';
import 'package:get/get.dart'; // Para Get.find
import 'package:speed_externo/stores/cliente_controller.dart';
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

  // Nova variável de controle para diferenciar mudanças programáticas de manuais
  bool _isProgrammaticChange = false;

  @override
  void initState() {
    super.initState();
    // Inicializa o TabController com o número de abas, o vsync e o índice inicial
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.rota);

    // Adiciona um listener ao TabController para detectar mudanças de aba
    _tabController.addListener(() {
      // Verifica se a aba está sendo selecionada (evita duplas chamadas durante a transição)
      if (_tabController.indexIsChanging) {
        // Se a mudança não foi programática, significa que o usuário clicou na aba
        if (!_isProgrammaticChange) {
          _onTabSelectedByUser(_tabController.index);
        }
        // Sempre resetar a flag após a verificação, para a próxima mudança
        _isProgrammaticChange = false;
      }
    });
    
    // Usa `autorun` do MobX para reagir a mudanças no cliente selecionado (`dadosCliente.clienSele`).
    // Sempre que `clienSele` mudar, esta função será executada.
    _disposer = autorun((_) {
      final selecionaCliente = dadosCliente.clienSele; // Acessa o cliente selecionado no store
      if (selecionaCliente != null && selecionaCliente.cnpj != null) {
        int targetIndex = _tabController.index; // Variável para o índice alvo

        // Verifica o tipo de documento e define o índice alvo
        if (selecionaCliente.cnpj!.isCpf) {
          targetIndex = 0; // Pessoa Física (índice 0)
        } else if (selecionaCliente.cnpj!.isCnpj) {
          targetIndex = 1; // Pessoa Jurídica (índice 1)
        }

        // Se o índice alvo for diferente do índice atual da aba, realiza a mudança
        if (_tabController.index != targetIndex) {
          _isProgrammaticChange = true; // Define a flag para indicar mudança programática
          _tabController.animateTo(targetIndex); // Mudar para a aba correspondente
        }
      }
    });
  }
  // Função a ser executada apenas quando o usuário clica na aba
  void _onTabSelectedByUser(int index) {
    if (index == 0 || index == 1) {
       Get.find<ClienteController>().resetForm();
    }
  }


  @override
  void dispose() {
    _tabController.removeListener(() {}); // É bom remover o listener no dispose
    _tabController.dispose(); // Descartar o TabController
    _disposer(); // Descartar o autorun do MobX para evitar vazamento de memória
    super.dispose();
    Get.find<ClienteController>().resetForm();
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