import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/forms/faturamento.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/cliente_controller.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/stores/pedido_dados.dart';
import 'package:speed_externo/stores/produto_controller.dart';
import 'package:speed_externo/stores/produto_dados.dart';

class Pedidoselec extends StatefulWidget {

  Pedido pedido ;

  Pedidoselec({
    Key? key,
    required this.pedido,
  }) : super(key: key);

  @override
  State<Pedidoselec> createState() => _PedidoselecState();
}

class _PedidoselecState extends State<Pedidoselec> {

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
  }
  
  @override
  void dispose() {    
    super.dispose();
  }

  void resetForm() {
    produtoStore.resetForm();
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
                                controller:  TextEditingController(text: '${widget.pedido.codClie}'),
                                readOnly: true,
                                labelText: 'Cliente',                                                                                      
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
                                controller: TextEditingController(text: '${widget.pedido.data}'),
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
                                value: widget.pedido.tipo == 1 ? '1 - A Vista' : '2 - A Prazo' ,
                                items: [''].map((String? value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text('$value'),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {},
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
                                            itemCount: widget.pedido.listProd!.length ,
                                            itemBuilder: (contextList, index) { 
                                              final produto = widget.pedido.listProd![index];
                                                Card(                                                     
                                                 // color: (int.tryParse(produto.nProd ?? '0') ?? 0) % 2 == 0? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.surfaceContainerHigh, 
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
                                                                controller: TextEditingController(text: '${produto.quantidade}'), 
                                                                readOnly: true,
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
                                                                            //controller: dadosStore.getControllerTotal(produto),
                                                                            readOnly: true,
                                                                )
                                                                ),
                                                            ],
                                                          )
                                                        ],
                                                      ),                                                                                       
                                                  ),
                                                );                                                                                                   
                                            },
                    )                                          
                ),
              ),            
                               
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
                              //controller: dadosStore.controllerDescPorcent,
                              readOnly: true,                                  
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
                        //controller: dadosStore.controllerDescReal,                            
                        readOnly: true,
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
                          //controller:  dadosStore.controllerTotalProd,
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
                          //controller: dadosStore.controllerTotalPedido,
                          readOnly: true, 
                          prefixText: 'R\$',
                        ),
                      )
                    ),
                  ],
                ),   
                SizedBox(height: 10),                                                                                     
                Observer(builder: (context) {
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
                ],
              );
          }),
                    ],
                  )                                                    
                ),
              )                                
              
            ],                
          ),
          
                      
                ),
        ),
      )
      );
    },);
  }
}