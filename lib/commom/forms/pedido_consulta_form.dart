import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/pedido_dados.dart';

class PedidoConsultaForm extends StatefulWidget {
  const PedidoConsultaForm({super.key});

  @override
  State<PedidoConsultaForm> createState() => _PedidoConsultaFormState();
}

class _PedidoConsultaFormState extends State<PedidoConsultaForm> {

  final pedidosDados = Get.find<DadosPedidoStore>();
  
  @override
  void initState() {
    super.initState();
    pedidosDados.obtemPedidos();
  }
   
  @override
  void dispose() {    
    super.dispose();
  }

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
             Observer(builder:  (conext) =>
                    Container(                    
                      height: screenSize.height * 0.9,
                      width: screenSize.width,
                        child: ListView.builder(
                                                shrinkWrap: true,                      
                                                itemCount: pedidosDados.listaDePedidos.length,
                                                itemBuilder: (contextList, index) { 
                                                  final pedido = pedidosDados.listaDePedidos[index];
                                                  return Card(                                                                                                         
                                                    child: ListTile(                                
                                                        title: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                 Expanded(
                                                                  flex: 1,
                                                                  child: CustomFormField( 
                                                                              labelText:  'Cod',
                                                                              controller:TextEditingController(text: pedido.cod),
                                                                              readOnly: true,
                                                                  )
                                                                ),
                                                                SizedBox(width: 5),
                                                                Expanded(
                                                                  flex: 6,
                                                                  child: CustomFormField( 
                                                                              labelText:  'Cliente  ',
                                                                              controller:TextEditingController(text: pedido.codClie),
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
                                                                  labelText:  'Status',
                                                                   controller: TextEditingController(text: pedido.status),
                                                                              readOnly: true,                                                                                                                                                                                                                 
                                                                  )
                                                                  ),
                                                                SizedBox(width: 5),
                                                               Expanded(
                                                                  flex: 2,
                                                                child: CustomFormField( 
                                                                              labelText:  'Faturamento',                                        
                                                                               controller: TextEditingController(text: pedido.faturamento.toString()),
                                                                              readOnly: true,
                                                                  )
                                                                  ),
                                                                  Expanded(
                                                                  flex: 2,
                                                                child: CustomFormField( 
                                                                              labelText:  'Total',
                                                                              controller: TextEditingController(text: ''),
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
           ],  
          )
          )          
        )          
        ),    
      );
    });      
  }
}