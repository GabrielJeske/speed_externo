import 'dart:developer';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/produto_controller.dart';
import 'package:speed_externo/stores/produto_dados.dart';



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
  
  var maskNcm = MaskTextInputFormatter(mask: '########', filter: {"#": RegExp(r'[0-9]')});
  var maskCst = MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  
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
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) => Column(
            children: [
              Row(
                children: [
                  SizedBox(height: 5),
                  Expanded(
                    flex: 2,
                      child: CustomFormField(
                        labelText: 'Cod',
                        controller: produtoStore.controllerCod,                                            
                        errorText: produtoStore.prodErrors[cod],                  
                        readOnly: widget.isConsulta,                    
                      ),                
                  ),                  
                  SizedBox(width:  10),
                  if (widget.isConsulta)
                  Expanded(
                    flex: 8,
                    child:                 
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
                  ),                 
                  if (!widget.isConsulta)
                  Expanded(
                    flex: 8,
                    child: CustomFormField(
                      controller: produtoStore.controllerNomeProd,
                      errorText: produtoStore.prodErrors[nome],
                      labelText: 'Nome',                                       
                      onChanged: (value) => produtoStore.setField(nome, value),                      
                    ),
                  ),        
                ],
              ),                                                    
              Observer( builder: (__) {
                if ( dadosProdutoStore.exibeListaProd) {
                  return Container(
                    constraints: BoxConstraints(maxHeight:  screenSize.height * 0.2),
                    child: ListView.builder(
                      shrinkWrap: true,                      
                      itemCount: dadosProdutoStore.listaFiltrada.length,
                      itemBuilder: (contextList, index) { 
                        final produto = dadosProdutoStore.listaFiltrada[index];
                        return ListTile(                          
                          title: Text(produto.nome ?? ''),
                          onTap: () {                                                            
                            dadosProdutoStore.selecionarProd(produto);                              
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
              }),                                                                             
              SizedBox(height:5),
              Row(
                children: [
                  Expanded(    
                    flex: 7,               
                    child: CustomFormField(
                      controller: produtoStore.controllerMarca,                                            
                      errorText: produtoStore.prodErrors[marca],
                      labelText: 'Marca',
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(marca, value),                      
                    ),
                  ),                              
                  SizedBox(width: 10),                  
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                      controller: produtoStore.controllerNcm,
                      mask: [maskNcm],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors[ncm],
                      labelText: 'NCM',
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(ncm, value),                      
                    ),
                  ),
                ]
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(        
                    flex: 8,           
                    child: CustomFormField(
                      controller: produtoStore.controllerApre,
                      labelText: 'Apresentação',
                      errorText: produtoStore.prodErrors[apresentacao],
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(apresentacao, value),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerCst,
                      mask: [maskCst],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors[cst],
                      labelText: 'CST',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(cst, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerUnidade,                      
                      labelText: 'UN',
                       readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[unidade],
                      onChanged: (value) => produtoStore.setField(unidade, value),                      
                    ),
                  ),                                   
                ],
              ),
              SizedBox(height:  5),
              Row(                
                children: [
                  Expanded(
                    flex: 3,
                    child:
                    CustomFormField(
                      controller: produtoStore.controllerGrupo1,
                      labelText: 'Grupo 1',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[grupo1],
                      onChanged: (value) => produtoStore.setField(grupo1, value),
                    ), 
                  ), 
                  SizedBox(width: 10),   
                  Expanded(
                    flex: 3,
                    child:
                    CustomFormField(
                      controller: produtoStore.controllerGrupo2,
                      labelText: 'Grupo 2',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[grupo2],
                      onChanged: (value) => produtoStore.setField(grupo2, value),
                    ), 
                  ),
                  SizedBox(width: 10),   
                  Expanded( flex: 3,
                    child:
                    CustomFormField(
                      controller: produtoStore.controllerGrupo3,
                      labelText: 'Grupo 3',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[grupo3],
                      onChanged: (value) => produtoStore.setField(grupo3, value),
                    ), 
                  ),                    
                ],
              ),
              SizedBox(height:  5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                       mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerCusto,
                      labelText: 'Custo',
                      keyboardType: TextInputType.number,
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[custo],
                      onChanged: (value) => produtoStore.setField(custo, value),                    
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                      mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerFabrica,
                      keyboardType: TextInputType.number,
                      labelText: 'Fabrica',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[fabrica],
                      onChanged: (value) => produtoStore.setField(fabrica, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                       mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: 'R\$',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerVenda,
                      keyboardType: TextInputType.number,
                      labelText: 'Venda',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[venda],
                      onChanged: (value) => produtoStore.setField(venda, value),                      
                    ),
                  )
                ],
              ),    
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerEstAtual,
                      keyboardType: TextInputType.number,
                      labelText: 'Estoque Atual',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[estoqueatual],
                      onChanged: (value) => produtoStore.setField(estoqueatual, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerEstParcial,
                      keyboardType: TextInputType.number,
                      labelText: 'Estoque Parcial',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[estoqueparcial],
                      onChanged: (value) => produtoStore.setField(estoqueparcial, value),                      
                    ),
                  ),
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
                          await dadosProdutoStore.salvaProduto();
                          Get.snackbar("Sucesso", "Produto salvo com sucesso!");   
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