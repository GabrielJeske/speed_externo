import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/pedido_dados.dart';


class Faturamento extends StatelessWidget {
  final pedidoDados = Get.find<DadosPedidoStore>();
   final pedidoStore = Get.find<PedidoStore>();
   final faturamento = Get.find<FaturamentoController>();

   Faturamento({super.key});




  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; 
   
    return Column(
      children: [
           
        Observer( builder: (context) {
          if (pedidoDados.pedido.tipo == 'A Prazo') {  
            return Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomFormField(
                  prefixText: 'R\$',
                  labelText: 'Entrada',       
                  controller: faturamento.entradaController,
                  errorText: pedidoStore.formErrors['entrada'],
                  onChanged: (value) => faturamento.setField('entrada', value),
                  keyboardType: TextInputType.number,              
                ),
              ),
              SizedBox(width: 5),
              Text('+'),
              SizedBox(width: 5),
              Expanded(
                flex: 2,
                child: CustomFormField(labelText: 'Parcelas',
                controller: faturamento.parcelasController,
                errorText: pedidoStore.formErrors['parcelas'],
                onChanged: (value) => faturamento.setField('parcelas', value),
                keyboardType: TextInputType.number,
                ),
              ),
            ],
          );
          } else {
             return SizedBox.shrink();
          }
        },           
        ),       
        SizedBox(height: 10),
        Row(
          children: [
            Flexible(
              child: DropdownButtonFormField<String>(
                                   decoration: InputDecoration(
                                     labelText: 'Tipo',
                                     border: OutlineInputBorder(),
                                     errorText: pedidoStore.formErrors['tipo'],
                                   ),
                                   // Usando a nova variável de estado
                                   value: 'Dinheiro',
                                   items: ['Dinheiro', 'Cartão Crédito'].map((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value),
                                     );
                                   }).toList(),
                                   onChanged: (String? newValue) {
                                     if (newValue != null) {                                       
                                       faturamento.setField('formaPagamento', newValue);                                       
                                     }
                                   },
                                 ),
            ),
          ],
        ),
        Observer(builder:  (conext) =>
                        Container(
                          height: screenSize.height * 0.30,
                          width: screenSize.width,
                            child: ListView.builder(
                                                    shrinkWrap: true,                      
                                                    itemCount: faturamento.contas.length,
                                                    itemBuilder: (contextList, index) { 
                                                      final conta = faturamento.contas[index];
                                                      return Card(
                                                        child: ListTile(                                
                                                            title: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                     Expanded(
                                                                      flex: 1,
                                                                      child: CustomFormField( 
                                                                                  labelText:  'Parcela',
                                                                                  controller:TextEditingController(text: conta.id),
                                                                                  readOnly: true,
                                                                      )
                                                                    ),
                                                                    SizedBox(width: 5),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child: CustomFormField( 
                                                                                  labelText:  'Vencimento',
                                                                                  controller:TextEditingController(text: conta.vencimento.toString()),
                                                                                  readOnly: true,
                                                                      )
                                                                      ),    
                                                                      SizedBox(height: 10),
                                                                Expanded(
                                                                  flex: 3,
                                                                 child: CustomFormField( 
                                                                              labelText:  'Valor',
                                                                              controller:TextEditingController(text: conta.valor.toString()),                                                                               
                                                                  )
                                                                  ),
                                                                SizedBox(width: 5),
                                                                                                                                 Expanded(
                                                                  flex: 4,
                                                                  child: CustomFormField( 
                                                                              labelText:  'Forma de Pagamento',
                                                                              controller:TextEditingController(text: conta.formaPagamento),
                                                                              readOnly: true,
                                                                  )
                                                                  ),                                                                                                         
                                                                  ],
                                                                
                                                                ),
                                                                                                                 
                                                              ],
                                                            ),                                                                                       
                                                        ),
                                                      );
                                                    },
                            )
                          
                          
                        ),
                      ),
      ],
    );
  }
}