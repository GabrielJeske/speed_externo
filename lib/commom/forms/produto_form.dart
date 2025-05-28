import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/produtoForm_store.dart';
import 'package:speed_externo/stores/dadosProduto_store.dart';
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
  final produtoStore = Get.find<ProdutoFormStore>();
  final dadosProdutoStore = Get.find<DadosProdutoStore>();
  
  var maskncm = MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
  var maskcst = MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  

  final FocusNode foco = FocusNode();
  
  

  @override
  void initState() {
    super.initState();
    if (widget.isConsulta){
      dadosProdutoStore.obtemProdutos();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosProdutoStore.setListaProd(foco.hasFocus);                     
        });  
     });
    }
     WidgetsBinding.instance.addPostFrameCallback((_) {
       produtoStore.resetForm();
       dadosProdutoStore.setFiltroProd('');
     });
  }
  
  @override
  void dispose() {    
    super.dispose();
    foco.dispose(); 
  }

  void resetForm() {
    produtoStore.resetForm();
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
                controller:  produtoStore.controllerNomeProd,
                labelText: 'Nome',
                foco: foco,
                onChanged: (value) {
                  log('Vai setar o filtro');
                  dadosProdutoStore.setFiltroProd(value);
                  dadosProdutoStore.setListaProd(foco.hasFocus);                 
                },
              ),
              Observer( 
                builder: (__) {
                  if ( dadosProdutoStore.exibeListaProd) {
                    return Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,                      
                        itemCount: dadosProdutoStore.listaFiltrada.length,
                        itemBuilder: (contextList, index) { 
                          final cliente = dadosProdutoStore.listaFiltrada[index];
                          return ListTile(                          
                            title: Text(cliente['nome'] ?? ''),
                            onTap: () {                              
                              log('Vai selecionar o cliente $cliente');
                              dadosProdutoStore.selecionarProd(cliente);                              
                              dadosProdutoStore.setListaProd(false);    
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
                      controller: produtoStore.controllerNomeProd,
                      errorText: produtoStore.prodErrors['nome'],
                      labelText: 'Nome',                                       
                      onChanged: (value) => produtoStore.setField('nome', value),                      
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(                   
                    child: CustomFormField(
                      controller: produtoStore.controllerMarca,                                            
                      errorText: produtoStore.prodErrors['marca'],
                      labelText: 'Marca',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField('marca', value),                      
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: produtoStore.controllerNcm,
                      mask: [maskncm],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors['ncm'],
                      labelText: 'NCM',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField('ncm', value),                      
                    ),
                  )                 
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: produtoStore.controllerCst,
                      mask: [maskcst],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors['cst'],
                      labelText: 'CST',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField('cst', value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: produtoStore.controllerUnidade,                      
                      labelText: 'UN',
                       readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors['un'],
                      onChanged: (value) => produtoStore.setField('un', value),                      
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: produtoStore.controllerCusto,
                      labelText: 'Custo',
                      keyboardType: TextInputType.number,
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors['custo'],
                      onChanged: (value) => produtoStore.setField('custo', value),                    
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: CustomFormField(
                      controller: produtoStore.controllerVenda,
                      keyboardType: TextInputType.number,
                      labelText: 'Venda',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors['venda'],
                      onChanged: (value) => produtoStore.setField('venda', value),                      
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
                      onPressed: produtoStore.resetForm,
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
                        produtoStore.validateAllFields('pf');
                        if (produtoStore.isFormValid) {
                          log("validou");
                          await dadosProdutoStore.salvaCliente();
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");   
                          produtoStore.resetForm();                                  
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