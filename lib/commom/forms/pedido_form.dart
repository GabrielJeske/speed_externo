import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/constantes/produto.dart';
import 'package:speed_externo/commom/forms/produto_form.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/dadosPedido_store.dart';
import 'package:speed_externo/stores/dadosProduto_store.dart';
import 'package:speed_externo/stores/pedidoForm_store.dart';
import 'package:speed_externo/stores/produtoForm_store.dart';

class PedidoForm extends StatefulWidget {
  const PedidoForm({super.key});

  @override
  State<PedidoForm> createState() => _PedidoFormState();
}
 
class _PedidoFormState extends State<PedidoForm> {
  final pedidoStore = Get.find<PedidoStore>();
  final dadosStore = Get.find<DadosPedidoStore>();
  final produtoStore = Get.find<ProdutoFormStore>();
  final dadosProdutoStore = Get.find<DadosProdutoStore>();

  final FocusNode foco = FocusNode();
  final FocusNode foco2 = FocusNode();
  
  

  @override
  void initState() {
    super.initState();
      dadosStore.obtemClientes();
      dadosProdutoStore.obtemProdutos();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosStore.setListaCliente(foco.hasFocus);                     
        });  
        
     });

       foco2.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosProdutoStore.setListaProd(foco2.hasFocus);                     
        });  
        
     });
    
     WidgetsBinding.instance.addPostFrameCallback((_) {
       pedidoStore.resetForm();
       dadosStore.setFiltro('');
       dadosProdutoStore.setFiltroProd('');
     });
  }
  
  @override
  void dispose() {    
    super.dispose();
    foco.dispose(); 
    foco2.dispose(); 
  }

  void resetForm() {
    produtoStore.resetForm();
    pedidoStore.resetForm();
    foco.dispose();    
    foco2.dispose(); 
  }

var maskdate = MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Observer(builder:  (_) => Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(              
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Observer(builder:  (_) => Column(                                              
                          children: [
                            Row(
                              children: [                                                    
                                Flexible(child:
                                  CustomFormField(
                                    controller:  pedidoStore.controllerCliente,
                                    labelText: 'Cliente',
                                    foco: foco,
                                    onChanged: (value) {    
                                      log('Vai setar o filtro');             
                                      dadosStore.setFiltro(value);
                                      log('Vai setar a Lista de Client'); 
                                      dadosStore.setListaCliente(foco.hasFocus);                 
                                    },
                                  ), 
                                ),                              
                              ],
                            ),
                            Observer( builder: (__) {
                                  if ( dadosStore.exibeListaCliente) {
                                    return Container(
                                      constraints: BoxConstraints(maxHeight: 200),
                                      child: ListView.builder(
                                        shrinkWrap: true,                      
                                        itemCount: dadosStore.listaFiltrada.length,
                                        itemBuilder: (contextList, index) { 
                                          final cliente = dadosStore.listaFiltrada[index];
                                          return ListTile(                          
                                            title: Text(cliente['nome'] ?? ''),
                                            onTap: () {                              
                                              log('chegou aqui');
                                              dadosStore.selecionarCliente(cliente, 'pf');                              
                                              dadosStore.setListaCliente(false);    
                                              foco.unfocus(); 
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                }),              
                            Row(
                              children: [
                                SizedBox(
                                  width: 150,                                
                                  child: CustomFormField(
                                    controller: pedidoStore.controllerData,
                                    mask: [maskdate],
                                    labelText: 'Data'
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox( 
                                  width: 150,                               
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(                        
                                      labelText: 'Tipo', 
                                      border: OutlineInputBorder(),
                                      errorText: pedidoStore.formErrors['tipo'],
                                    ),
                                    value: '1 - A vista',
                                    items: ['1 - A vista', '2 - A prazo'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null){    
                                        pedidoStore.setField('tipo', newValue)                                ;
                                      }                   
                                    },
                                  )
                                ),                            
                              ],
                            )                    
                          ],
                        ),
                      ),
                    ),
                  ),
                  Observer(builder:  (_) =>
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        child:ListView.builder(
                          shrinkWrap: true,                      
                          itemCount: dadosStore.listaProdutos.length,
                          itemBuilder: (contextList, index) { 
                            final produto = dadosStore.listaProdutos[index];
                            return Dismissible(  
                              background:  Container(color: Colors.green),
                              key: ValueKey(dadosStore.listaProdutos[index]),     
                              onDismissed: (direction) {
                                
                              },        
                              child: ListTile(
                                  title: Text(produto.nome ?? ''),                              
                              ),           
                              
                            );
                          },
                        ),
                    
                      ),
                      
                    ),
                  ),
                  Card(child: 
                   ElevatedButton(
                        onPressed:
          () => showDialog<String>(
            context: context,
            builder:                  
              (BuildContext context) {

                final Size screenSize = MediaQuery.of(context).size;
                final double dialogWidth = screenSize.width * 0.9;
                final double dialogHeight = screenSize.height * 0.9;

                return AlertDialog(
                  title: const Text('Inclusão de Produtos'),
                  content: SizedBox(
                    width: dialogWidth,
                    height: dialogHeight,
                    child: ProdutoForm(isConsulta: true,)
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Produto produtoSelec = produtoStore.prod;
                        log('vai obter o objeto do Produto $produtoSelec');
                        dadosStore.addProd(produtoSelec);
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Salvar'),
                    ),
                  ],
                );
              }
          ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          padding: EdgeInsets.all(15),
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(fontSize: 20)
                        ),
                        child: Text('Add')
                      )  
                  )
                ],
              ),
          ),
      ),
    );
  }
}