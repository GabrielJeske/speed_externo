import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/stores/pedido_dados.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/produto_controller.dart';


class Faturamento extends StatelessWidget {
  final dadosStore = Get.find<DadosPedidoStore>();
  final produtoStore = Get.find<ProdutoFormStore>();
  
   Faturamento({super.key});




  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 

    return  Observer(builder:  (conext) =>
    
                    Container(                    
                      height: screenSize.height * 0.45,
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
                                                      
                                                    },        
                                                    child: Card(
                                                      child: ListTile(                                
                                                          title: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                   Expanded(
                                                                    flex: 1,
                                                                    child: CustomFormField( 
                                                                                labelText:  'Parcela',
                                                                                controller:TextEditingController(text: produto.cod),
                                                                                readOnly: true,
                                                                    )
                                                                  ),
                                                                  SizedBox(width: 5),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: CustomFormField( 
                                                                                labelText:  'Vencimento',
                                                                                controller:TextEditingController(text: produto.nome),
                                                                                readOnly: true,
                                                                    )
                                                                    ),    
                                                                    SizedBox(height: 10),
                                                              Expanded(
                                                                flex: 3,
                                                               child: CustomFormField( 
                                                                            labelText:  'Valor',
                                                                            controller:TextEditingController(text: produto.quantidade),
                                                                            onChanged: (value) => produtoStore.setField(quantidade, value),
                                                                            readOnly: false,
                                                                )
                                                                ),
                                                              SizedBox(width: 5),
                                                                                                                               Expanded(
                                                                flex: 4,
                                                              child: CustomFormField( 
                                                                            labelText:  'Forma de Pagamento',                                        
                                                                            controller:TextEditingController(text: produto.venda),
                                                                            readOnly: true,
                                                                )
                                                                ),                                                                                                         
                                                                ],
                                                              
                                                              ),
                                                                                                               
                                                            ],
                                                          ),                                                                                       
                                                      ),
                                                    ),           
                                                    
                                                  );
                                                },
                        )
                      
                      
                    ),
                  );
  }
}