import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/forms/faturamento.dart';
import 'package:speed_externo/commom/forms/produto_form.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
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
  final clienteStore = Get.find<ClienteController>();
  final dadosCliente = Get.find<ClienteDados>();
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
                                    onTap:   () {
                                    if (!dadosStore.edit) {
                                      pedidoStore.resetClie();
                                    }                                    
                                    },                                    
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
                                    value: pedidoStore.tipoSelecionado,
                                    items: ['1 - A Vista','2 - A Prazo'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {                                      
                                        pedidoStore.setField('tipo', newValue.substring(0, 1));   
                                        pedidoStore.setTipo(newValue);
                                      }
                                    },
                                    style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
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
                                                    background:  Container(
                                                      color: Theme.of(context).colorScheme.errorContainer,
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(right: 16.0),
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Theme.of(context).colorScheme.onErrorContainer,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    key: ValueKey(dadosStore.listaProdutos[index]),     
                                                    onDismissed: (direction) {
                                                      dadosStore.removerProd(produto);
                                                    },        
                                                    child: Card(                                                     
                                                      color: produto.nProd! % 2 == 0? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerHigh, 
                                                      child: ListTile(                                
                                                          title: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                   Expanded(
                                                                    flex: 1,
                                                                    child: CustomFormField( 
                                                                                labelText:  'Cod',
                                                                                controller:TextEditingController(text: '${produto.cod}'),
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
                                                                                controller:TextEditingController(text: '${produto.venda}'),
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
                     CustomButtom(
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
                     CustomButtom(
                        onPressed: () => Navigator.pop(context),
                        label: Text('Cancelar'),
                      ),
                      CustomButtom(                  
                        onPressed: () {                        
                          dadosStore.addProd(dadosProdutoStore.prodSele);
                          Navigator.pop(context);
                          dadosStore.setEdit(true);
                        },
                        label: const Text('Salvar'),
                      ),
                                    ],
                                  )
                     
                    ],
                              );
                              
                                  }
                          ),
                         label: Icon(Icons.add),
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
    if (dadosStore.listaProdutos.isNotEmpty) {
      return Row(
      children: [                                                      
        Expanded(
          flex:4,
          child: CustomButtom(onPressed: () {
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
                        CustomButtom(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          label: const Text('Cancelar'),
                        ),
                        CustomButtom(
                          onPressed: () {
                            faturamento.salvarFaturamento();
                            Navigator.of(context).pop();
                          },
                          label: const Text('Confirmar'),
                        ),
                      ],
                      ),
                    );
                  });
              },
              label: Text('Faturamento'),
          ),
        ),
        SizedBox(width: 10),
        if (!pedidoStore.isAPrazo || faturamento.faturamento.contas.isNotEmpty)
        Expanded(
          flex: 4,        
          child: CustomButtom(
            onPressed: () {
             showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    return 
                       AlertDialog(
                         title: const Text('Finalizar Pedido'),
                         content: const Text('Tem certeza que deseja finalizar o pedido?'),
                         actions: <Widget>[
                           CustomButtom(
                             onPressed: () {              
                               Navigator.of(context).pop();
                             },
                             label: const Text('Cancelar'),
                           ),
                           CustomButtom(
                             onPressed: () {
                              dadosStore.salvaPedido();                            
                               Navigator.of(context).pop();
                             },
                             label: const Text('Confirmar'),
                           ),
                         ],
                       );
                  
                  });
              },
              label: Text('Finalizar Pedido'),
          ),
        ),
      ],
    );
    } else {
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
                                   left: screenSize.width * 0.0,
                                   right: screenSize.height *0.0 ,
                                  child: Card(                                    
                                    child: Container(
                                      constraints: BoxConstraints(maxHeight: screenSize.height *0.2),
                                      child: ListView.builder(
                                        shrinkWrap: true,                      
                                        itemCount: dadosCliente.listaFiltrada.length,
                                        itemBuilder: (contextList, index) { 
                                          final cliente = dadosCliente.listaFiltrada[index];
                                          return 
                                          ListTile(                          
                                          contentPadding: EdgeInsets.all(0),
                                            title: Row(
                                              children: [
                                                SizedBox(width: 10),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(cliente.razaosocial ?? '', style: TextStyle(fontSize: 12),),
                                                ),                                             
                                              SizedBox(width: 10),
                                              SizedBox(
                                                height: 25,
                                                child: VerticalDivider(
                                                  color: Theme.of(context).colorScheme.outline, // Cor da sua linha (como você já estava a usar)
                                                  thickness: 2,        // Espessura da sua linha
                                                  indent: 0,           // Remove qualquer espaçamento em cima
                                                  endIndent: 0,        // Remove qualquer espaçamento em baixo
                                                  width: 10,           // Largura que o divisor ocupa na Row (ajuste se precisar de mais espaço lateral)
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                flex: 2,
                                                child: Text(cliente.fantasia ?? '', style: TextStyle(fontSize: 12),),
                                              ),
                                              ],
                                            ),
                                            onTap: () {                                                                                            
                                              dadosCliente.selecionarCliente(cliente);                              
                                              dadosCliente.setListaCliente(false);  
                                              pedidoStore.setField('cliente', cliente.toString());  
                                              pedidoStore.setField('nome', cliente.razaosocial.toString());  
                                              pedidoStore.setField('codClie', cliente.id.toString());                                                                                                                                                                                                             
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