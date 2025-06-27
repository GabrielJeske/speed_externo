import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/forms/faturamento.dart';
import 'package:speed_externo/commom/forms/produto_form.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/cliente_controller.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_dados.dart';
import 'package:speed_externo/stores/produto_dados.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/stores/produto_controller.dart';

class PedidoForm extends StatefulWidget {
  const PedidoForm({super.key});

  @override
  State<PedidoForm> createState() => _PedidoFormState();
}
 
class _PedidoFormState extends State<PedidoForm> {

  final pedidoStore = Get.find<PedidoStore>();
  final dadosStore = Get.find<DadosPedidoStore>();
  final clienteStore = Get.find<FormStore>();
  final dadosCliente = Get.find<DadosStore>();
  final produtoStore = Get.find<ProdutoFormStore>();
  final dadosProdutoStore = Get.find<DadosProdutoStore>();
  final faturamento = Get.find<FaturamentoController>();

  final FocusNode foco = FocusNode();
  final FocusNode foco2 = FocusNode();

  @override
  void initState() {
    super.initState();
      dadosCliente.obtemClientes();
      dadosProdutoStore.obtemProdutos();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosCliente.setListaCliente(foco.hasFocus);
        });
      });

       foco2.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosProdutoStore.setListaProd(foco2.hasFocus);                     
        });  
        
     });
    
     WidgetsBinding.instance.addPostFrameCallback((_) {
       dadosCliente.setFiltro('');
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
    foco.dispose();    
    foco2.dispose(); 
  }

  var maskdate = MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  var maskporcent = MaskTextInputFormatter(mask: '###%# ', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {  
    final Size screenSize = MediaQuery.of(context).size; 

    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(constraints: BoxConstraints(         
          maxHeight: screenSize.height,
        ),
        child: IntrinsicHeight(
          child: Container(      
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(                
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
                                    readOnly: dadosStore.edit,
                                    labelText: 'Cliente',
                                    foco: foco,                                                              
                                    onChanged: (value) {                                                                                                                                                  
                                      dadosCliente.setFiltro(value);                                                                      
                                      dadosCliente.setListaCliente(foco.hasFocus);                                    
                                    },
                                  ), 
                                ),                              
                              ],
                            ),                        
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  flex: 5,                                
                                  child: CustomFormField(
                                    controller: pedidoStore.controllerData,
                                    mask: [maskdate],
                                    labelText: 'Data',
                                    readOnly: true,
                                  ),
                                ),
                                SizedBox(width: 10),
                               Observer(
                                builder: (context) => Expanded(
                                  flex: 5,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Tipo',
                                      border: OutlineInputBorder(),
                                      errorText: pedidoStore.formErrors['tipo'],
                                    ),
                                    // Usando a nova variável de estado
                                    value: pedidoStore.tipoSelecionado,
                                    items: ['A Vista', 'A Prazo'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        // Apenas chama a ação 'setField' que já faz todo o trabalho
                                        pedidoStore.setField('tipo', newValue);                                       
                                      }
                                    },
                                  ),
                                ),
                              ),
                              ],
                            )                    
                          ],
                        ),
                      ),
                    ),                    
                  ),
                  Observer(builder:  (conext) =>
                    Container(                    
                      height: screenSize.height * 0.38,
                      width: screenSize.width,
                        child: ListView.builder(
                                                shrinkWrap: true,                      
                                                itemCount: dadosStore.listaProdutos.length,
                                                itemBuilder: (contextList, index) { 
                                                  final produto = dadosStore.listaProdutos[index];
                                                  return Dismissible(                                
                                                    background:  Container(color: Colors.red),
                                                    key: ValueKey(dadosStore.listaProdutos[index]),     
                                                    onDismissed: (direction) {
                                                      dadosStore.removerProd(produto);
                                                    },        
                                                    child: Card(                                                     
                                                      color: (int.tryParse(produto.nProd ?? '0') ?? 0) % 2 == 0? Colors.black12 : Colors.black38, 
                                                      child: ListTile(                                
                                                          title: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                   Expanded(
                                                                    flex: 1,
                                                                    child: CustomFormField( 
                                                                                labelText:  'Cod',
                                                                                controller:TextEditingController(text: produto.cod),
                                                                                readOnly: true,
                                                                    )
                                                                  ),
                                                                  SizedBox(width: 5),
                                                                  Expanded(
                                                                    flex: 6,
                                                                    child: CustomFormField( 
                                                                                labelText:  'Nome',
                                                                                controller:TextEditingController(text: produto.nome),
                                                                                readOnly: true,
                                                                    )
                                                                    ),                                                                                               
                                                                ],
                                                              
                                                              ),
                                                              SizedBox(height: 10),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 2,
                                                                   child: CustomFormField( 
                                                                    labelText:  'Quantidade',
                                                                    controller: dadosStore.getControllerQtd(produto), 
                                                                    onChanged: (value) => dadosStore.calculaTotalPedido(),                                                                                                                                                                                                                       
                                                                    )
                                                                    ),
                                                                  SizedBox(width: 5),
                                                                 Expanded(
                                                                    flex: 2,
                                                                  child: CustomFormField( 
                                                                                labelText:  'Venda',                                        
                                                                                controller:TextEditingController(text: produto.venda),
                                                                                readOnly: true,
                                                                    )
                                                                    ),
                                                                    Expanded(
                                                                    flex: 2,
                                                                  child: CustomFormField( 
                                                                                labelText:  'Total',
                                                                                controller: dadosStore.getControllerTotal(produto),
                                                                                readOnly: true,
                                                                    )
                                                                    ),
                                                                ],
                                                              )
                                                            ],
                                                          ),                                                                                       
                                                      ),
                                                    ),           
                                                    
                                                  );
                                                },
                        )                                          
                    ),
                  ),
                  //if (pedidoStore.pedido.codClie != null && pedidoStore.pedido.codClie!.isNotEmpty)
                  Observer( builder: (_) {
                    return pedidoStore.pedido.codClie != null
                    ? Card(child: 
                     ElevatedButton(
                          onPressed:                        
                          () => showDialog<String>(
                          context: context,
                          builder:                  
                                  (BuildContext context) {                          
                                    return AlertDialog(
                                title: const Text('Inclusão de Produtos'),
                                content: ConstrainedBox( // Ou FractionallySizedBox
                                  constraints: BoxConstraints(
                                    maxWidth: 600.0, // Exemplo: Largura máxima para desktops/tablets
                                    maxHeight: screenSize.height * 0.8, // Exemplo: Altura máxima proporcional, mas com limite
                                    minHeight: screenSize.height * 0.4, // Exemplo: Altura mínima para não ficar minúsculo
                                  ),
                                  child: SizedBox( // Envolver o ProdutoForm dentro de um SizedBox para dar um tamanho inicial
                                    width: screenSize.width * 0.7, // Ou um valor um pouco mais flexível
                                    height: screenSize.height * 0.5,
                                    child: ProdutoForm(isConsulta: true),
                                  ),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                     ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(                  
                        onPressed: () {                        
                          dadosStore.addProd(dadosProdutoStore.prodSele);
                          Navigator.pop(context);
                          dadosStore.setEdit(true);
                        },
                        child: const Text('Salvar'),
                      ),
                                    ],
                                  )
                     
                    ],
                              );
                              
                                  }
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(5),
                            foregroundColor: Colors.black,
                            textStyle: TextStyle(fontSize: 20)
                          ),
                          child: Icon(Icons.add)
                        )  
                    ): SizedBox.shrink();
                  }),
                  
                  Card(                      
                    child: Container(              
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(               
                      children: [
                        Expanded(
                          flex: 4,                                        
                            child: Column(
                              children: [                          
                                CustomFormField(                                  
                                  keyboardType: TextInputType.number,
                                  mask: [maskporcent],
                                  labelText: 'Desconto %',
                                  controller: dadosStore.controllerDescPorcent,
                                  onChanged: (value) {
                                    dadosStore.calculaDescReal(value);
                            
                                  },
                                )
                              ],
                            ),                                              
                        ), 
                        SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child:CustomFormField(
                            prefixText: 'R\$',
                            labelText: 'Desconto R\$',
                            controller: dadosStore.controllerDescReal,                            
                            onChanged: (value) {
                              dadosStore.calculaDescPorcent(value);
                             
                            },
                          )
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                           Expanded(
                          flex: 4, child: Observer(
                            builder: (_) => CustomFormField(
                              labelText: 'Subtotal',
                              controller: dadosStore.controllerTotalProd,
                              readOnly: true, 
                              prefixText: 'R\$',
                            ),
                          )
                        ),                 
                        SizedBox(width: 10),                                               
                         Expanded(
                          flex: 4, child: Observer(
                            builder: (_) => CustomFormField(
                              labelText: 'Total Venda',
                              controller: dadosStore.controllerTotalPedido,
                              readOnly: true, 
                              prefixText: 'R\$',
                            ),
                          )
                        ),
                      ],
                    ),   
                    SizedBox(height: 10),                                                                                     
                    Observer(builder: (context) {
    // Usando o valor computado, que é mais seguro
    if (dadosStore.listaProdutos.isNotEmpty) {
      // Lógica para 'A Vista' (dois botões)
      return Row(
      children: [                                                      
        Expanded(
          flex:4,
          child: ElevatedButton(onPressed: () {
          faturamento.total = dadosStore.totalPedido;
          faturamento.geraContas();
            showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return Observer(builder: (context) => 
                       AlertDialog(
                        title: const Text('Faturamento'),
                        content: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: screenSize.width,
                            maxHeight: screenSize.height * 0.8,
                            minHeight: screenSize.height * 0.4,
                          ),
                          child: SizedBox(
                            width: screenSize.width ,
                            height: screenSize.height * 0.5,
                            child: Faturamento(),
                          ),
                        ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            faturamento.salvarFaturamento();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirmar'),
                        ),
                      ],
                      ),
                    );
                  });
              },
              child: Text('Faturamento'),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 4,
          child: ElevatedButton(
            onPressed: () {
             showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return 
                       AlertDialog(
                         title: const Text('Finalizar Pedido'),
                         content: const Text('Tem certeza que deseja finalizar o pedido?'),
                         actions: <Widget>[
                           ElevatedButton(
                             onPressed: () {
                               log('Pedido cancelado');
                               Navigator.of(context).pop();
                             },
                             child: const Text('Cancelar'),
                           ),
                           ElevatedButton(
                             onPressed: () {
                              dadosStore.salvaPedido();
                               log('Pedido finalizado');
                               print(pedidoStore.pedido.toJson());
                               Navigator.of(context).pop();
                             },
                             child: const Text('Confirmar'),
                           ),
                         ],
                       );
                  
                  });
              },
              child: Text('Finalizar Pedido'),
          ),
        ),
      ],
    );
    } else {
      // Se não for 'A Vista' nem 'A Prazo', retorna SizedBox.shrink()
      return SizedBox.shrink();
    }
}),
                        ],
                      )                                                    
                    ),
                  )                                
                  
                ],                
              ),             
              Observer( builder: (__) {
                              if ( dadosCliente.exibeListaCliente && dadosStore.listaProdutos.isEmpty) {
                                return Positioned(
                                   top: screenSize.height * 0.1,
                                   left: screenSize.width * 0.01,
                                   right: screenSize.height *0.2 ,
                                  child: Card(                                    
                                    child: Container(
                                      constraints: BoxConstraints(maxHeight: screenSize.height *0.2),
                                      child: ListView.builder(
                                        shrinkWrap: true,                      
                                        itemCount: dadosCliente.listaFiltrada.length,
                                        itemBuilder: (contextList, index) { 
                                          final cliente = dadosCliente.listaFiltrada[index];
                                          return ListTile(                          
                                            title: Text(cliente.razaosocial ?? ''),
                                            onTap: () {                                                                      
                                              log('chegou aqui 1 ');
                                              dadosCliente.selecionarCliente(cliente, 'pf');                              
                                              dadosCliente.setListaCliente(false);  
                                              pedidoStore.setField('cliente', cliente.toString());  
                                              pedidoStore.setField('nome', cliente.razaosocial.toString());  
                                              pedidoStore.setField('codClie', cliente.id.toString());                                                 
                                             // dadosStore.addClie(cliente);                                                                                                                  
                                              foco.unfocus();                                          
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            }),        
            ],
            
          ),
          
                      
                ),
        ),
      )
      );
    },);
  }
}