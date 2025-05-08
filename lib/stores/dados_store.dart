import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/stores/form_store.dart';

part 'dados_store.g.dart';


class DadosStore =_DadosStoreBase with _$DadosStore;

abstract class _DadosStoreBase with Store{


  Future<File> obtemFileClie() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      final f = File('$path/clientes.json');
      bool fExiste = await f.exists();
      if (fExiste) {
        return f;
      } else {
        List<Map<String, dynamic>> mClientes = [];
        final jClientes = jsonEncode(mClientes);
        await f.writeAsString(jClientes);
        return f;
      }
    } catch (e) {
      log('Erro em obtemFileClie: $e');
      rethrow; // Ou retorne null, ou trate conforme apropriado para seu aplicativo
    }
  }

  Future<int> obtemId() async {
    try {
      final json = await obtemFileClie();
      final contJson = await json.readAsString();
      final dynamic decodedJson = jsonDecode(contJson);

      List<Map<String, dynamic>> listaDeClientes = [];

      if (decodedJson is List) {
        listaDeClientes = decodedJson.cast<Map<String, dynamic>>().toList();
      } else if (decodedJson is Map) {
        listaDeClientes.add(decodedJson.cast<String, dynamic>());
      } else {
        log('Estrutura JSON inesperada em obtemId');
        return 1; // Ou lance uma exceção, ou trate de forma diferente
      }

      if (listaDeClientes.isNotEmpty) {
        final ultimoCliente = listaDeClientes.last;
        if (ultimoCliente.containsKey('id') && ultimoCliente['id'] is String) {
          try {
            int ultimoID = int.parse(ultimoCliente['id']);
            return ultimoID + 1;
          } catch (e) {
            log('Erro ao analisar o id em obtemId: $e');
            return 1; // Ou lance uma exceção, ou trate de forma diferente
          }
        } else {
          log('Último cliente não tem um id válido em obtemId');
          return 1; // Ou lance uma exceção
        }
      } else {
        return 1;
      }
    } catch (e) {
      log('Erro em obtemId: $e');
      return 1; // Ou lance uma exceção
    }
  }

  Future<void> salvaCliente() async {
    
    final formStore = Get.find<FormStore>();
    
    try {
      final int id = await obtemId();
      final fCliente = await obtemFileClie();
      final String contJson = await fCliente.readAsString();
      final dynamic decodedJson = jsonDecode(contJson);

      List<Map<String, dynamic>> clientes = [];
      if (decodedJson is List) {
        clientes = decodedJson.cast<Map<String, dynamic>>().toList();
      } else if (decodedJson is Map) {
        clientes.add(decodedJson.cast<String, dynamic>());
      }

      if (formStore.formValues.isNotEmpty) {
        final Map<String, String> cliente = Map<String, String>.from(formStore.formValues); // Use Map.from
        cliente['id'] = '$id'; // Linha corrigida
        clientes.add(Map<String, dynamic>.from(cliente)); // Adiciona como mapa dinâmico
        await fCliente.writeAsString(jsonEncode(clientes)); // Escreve de volta no arquivo
        log('Cliente salvo: $clientes');
      } else {
        log('Valores vazios em salvaCliente');
      }
    } catch (e) {
      log('Erro em salvaCliente: $e');
      rethrow; // Ou trate o erro como apropriado
    }
  }


  Future<void> consultaCliente() async {
    
    final formStore = Get.find<FormStore>();
    
    try {
      final int id = await obtemId();
      final fCliente = await obtemFileClie();
      final String contJson = await fCliente.readAsString();
      final dynamic decodedJson = jsonDecode(contJson);

      List<Map<String, dynamic>> clientes = [];
      if (decodedJson is List) {
        clientes = decodedJson.cast<Map<String, dynamic>>().toList();
      } else if (decodedJson is Map) {
        clientes.add(decodedJson.cast<String, dynamic>());
      }

      if (formStore.formValues.isNotEmpty) {
        final Map<String, String> cliente = Map<String, String>.from(formStore.formValues); // Use Map.from
        cliente['id'] = '$id'; // Linha corrigida
        clientes.add(Map<String, dynamic>.from(cliente)); // Adiciona como mapa dinâmico
        await fCliente.writeAsString(jsonEncode(clientes)); // Escreve de volta no arquivo
        log('Cliente salvo: $clientes');
      } else {
        log('Valores vazios em salvaCliente');
      }
    } catch (e) {
      log('Erro em salvaCliente: $e');
      rethrow; // Ou trate o erro como apropriado
    }
  }

}

