import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/clienteForm_store.dart';
import 'package:speed_externo/stores/dadosCliente_store.dart';
import 'package:speed_externo/stores/dados_store.dart';
import 'package:speed_externo/stores/form_store.dart';


class ProdutoForm extends StatefulWidget {
  final bool isConsulta;

  ProdutoForm({
    Key? key,
    this.isConsulta = false,
  }) : super(key: key);

  @override
  State<ProdutoForm> createState() => _ProdutoFormState();
}

class _ProdutoFormState extends State<ProdutoForm> {
  final clienteStore = Get.find<ClienteFormStore>();
  final dadosClienteStore = Get.find<DadosClienteStore>();
  
  var maskncm = MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
  var maskcst = MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  

  final FocusNode foco = FocusNode();
  
  

  @override
  void initState() {
    super.initState();
    if (widget.isConsulta){
      dadosClienteStore.obtemProdutos();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosClienteStore.setListaProd(foco.hasFocus);                     
        });  
     });
    }
     WidgetsBinding.instance.addPostFrameCallback((_) {
       clienteStore.resetForm();
       dadosClienteStore.setFiltroProd('');
     });
  }
  
  @override
  void dispose() {    
    super.dispose();
    foco.dispose(); 
  }

  void resetForm() {
    clienteStore.resetForm();
    foco.dispose();    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) => Column(
            children: [
              SizedBox(height: 20),
              if (widget.isConsulta)
              CustomFormField(
                controller:  clienteStore.controllerNomeProd,
                labelText: 'Nome',
                foco: foco,
                onChanged: (value) {
                  log('Vai setar o filtro');
                  dadosClienteStore.setFiltroProd(value);
                  dadosClienteStore.setListaProd(foco.hasFocus);                 
                },
              ),
              Observer( 
                builder: (__) {
                  if ( dadosClienteStore.exibeListaProd) {
                    return Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,                      
                        itemCount: dadosClienteStore.listaFiltrada.length,
                        itemBuilder: (contextList, index) { 
                          final cliente = dadosClienteStore.listaFiltrada[index];
                          return ListTile(                          
                            title: Text(cliente['nome'] ?? ''),
                            onTap: () {                              
                              log('Vai selecionar o cliente $cliente');
                              dadosClienteStore.selecionarProd(cliente);                              
                              dadosClienteStore.setListaProd(false);    
                              foco.unfocus(); 
                            },
                          );
                        },
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ), 
              if (!widget.isConsulta)
              Row(
                children: [                
                  Flexible(
                    child: CustomFormField(
                      controller: clienteStore.controllerNomeProd,
                      errorText: clienteStore.prodErrors['nome'],
                      labelText: 'Nome',                                       
                      onChanged: (value) => clienteStore.setField('nome', value),                      
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(                   
                    child: CustomFormField(
                      controller: clienteStore.controllerMarca,                                            
                      errorText: clienteStore.prodErrors['marca'],
                      labelText: 'Marca',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => clienteStore.setField('marca', value),                      
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: clienteStore.controllerNcm,
                      mask: [maskncm],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: clienteStore.prodErrors['ncm'],
                      labelText: 'NCM',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => clienteStore.setField('ncm', value),                      
                    ),
                  )                 
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: clienteStore.controllerCst,
                      mask: [maskcst],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: clienteStore.prodErrors['cst'],
                      labelText: 'CST',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => clienteStore.setField('cst', value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: clienteStore.controllerUnidade,                      
                      labelText: 'UN',
                       readOnly: widget.isConsulta,
                      errorText: clienteStore.prodErrors['un'],
                      onChanged: (value) => clienteStore.setField('un', value),                      
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: clienteStore.controllerCusto,
                      labelText: 'Custo',
                      keyboardType: TextInputType.number,
                      readOnly: widget.isConsulta,
                      errorText: clienteStore.prodErrors['custo'],
                      onChanged: (value) => clienteStore.setField('custo', value),                    
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: CustomFormField(
                      controller: clienteStore.controllerVenda,
                      keyboardType: TextInputType.number,
                      labelText: 'Venda',
                      readOnly: widget.isConsulta,
                      errorText: clienteStore.prodErrors['venda'],
                      onChanged: (value) => clienteStore.setField('venda', value),                      
                    ),
                  )
                ],
              ),             
              SizedBox(height: 30),
              if (!widget.isConsulta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: clienteStore.resetForm,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(15),
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      child: Text('CANCELAR'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        clienteStore.validateAllFields('pf');
                        if (clienteStore.isFormValid) {
                          log("validou");
                          await dadosClienteStore.salvaCliente();
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");   
                          clienteStore.resetForm();                                  
                        } else {                                                  
                          log("nao salvou nem validou");
                          Get.snackbar("Erro", "Por favor, corrija os erros no formulário.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(15),
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text('SALVAR'),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
} 