import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/produto_controller.dart';
import 'package:speed_externo/stores/produto_dados.dart';

class ProdutoForm extends StatefulWidget {
  final bool isConsulta;
  final bool isAlteracao;

  ProdutoForm({
    Key? key,
    this.isConsulta = false,
    this.isAlteracao = false,
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
                        errorText: produtoStore.prodErrors[codProd],                  
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
                      onTap: () {
                        produtoStore .resetForm();
                      },
                      onChanged: (value) {                     
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
                      errorText: produtoStore.prodErrors[nomeProd],
                      labelText: 'Nome',                                       
                      onChanged: (value) => produtoStore.setField(nomeProd, value),                      
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
                      errorText: produtoStore.prodErrors[marcaProd],
                      labelText: 'Marca',
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(marcaProd, value),                      
                    ),
                  ),                              
                  SizedBox(width: 10),                  
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                      controller: produtoStore.controllerNcm,
                      mask: [maskNcm],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors[ncmProd],
                      labelText: 'NCM',
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(ncmProd, value),                      
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
                      errorText: produtoStore.prodErrors[apresentProd],
                      readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(apresentProd, value),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerCst,
                      mask: [maskCst],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: produtoStore.prodErrors[cstProd],
                      labelText: 'CST',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => produtoStore.setField(cstProd, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: CustomFormField(
                      controller: produtoStore.controllerUnidade,                      
                      labelText: 'UN',
                       readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[unidadeProd],
                      onChanged: (value) => produtoStore.setField(unidadeProd, value),                      
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
                      errorText: produtoStore.prodErrors[grupo1Prod],
                      onChanged: (value) => produtoStore.setField(grupo1Prod, value),
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
                      errorText: produtoStore.prodErrors[grupo2Prod],
                      onChanged: (value) => produtoStore.setField(grupo2Prod, value),
                    ), 
                  ),
                  SizedBox(width: 10),   
                  Expanded( flex: 3,
                    child:
                    CustomFormField(
                      controller: produtoStore.controllerGrupo3,
                      labelText: 'Grupo 3',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[grupo3Prod],
                      onChanged: (value) => produtoStore.setField(grupo3Prod, value),
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
                      prefixText: 'R\$',
                       mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: '',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerCusto,
                      labelText: 'Custo',
                      keyboardType: TextInputType.number,
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[custoProd],
                      onChanged: (value) => produtoStore.setField(custoProd, value),                    
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                      prefixText: 'R\$',
                      mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: '',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerFabrica,
                      keyboardType: TextInputType.number,
                      labelText: 'Fabrica',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[fabricaProd],
                      onChanged: (value) => produtoStore.setField(fabricaProd, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 3,
                    child: CustomFormField(
                      prefixText: 'R\$',
                       mask: [
                        CurrencyTextInputFormatter.currency(
                          locale: 'pt_BR',
                          symbol: '',
                          decimalDigits: 2,
                        ),
                      ],
                      controller: produtoStore.controllerVenda,
                      keyboardType: TextInputType.number,
                      labelText: 'Venda',
                      readOnly: widget.isConsulta,
                      errorText: produtoStore.prodErrors[vendaProd],
                      onChanged: (value) => produtoStore.setField(vendaProd, value),                      
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
                      errorText: produtoStore.prodErrors[estqatualProd],
                      onChanged: (value) => produtoStore.setField(estqatualProd, value),                      
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
                      errorText: produtoStore.prodErrors[estqparcialProd],
                      onChanged: (value) => produtoStore.setField(estqparcialProd, value),                      
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (!widget.isConsulta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtom(
                      onPressed: produtoStore.resetForm,
                      label: Text('Cancelar'),
                    ),
                    SizedBox(width: 10),
                    CustomButtom(
                      onPressed: () async {
                        produtoStore.validateAllFields('pf');
                        if (produtoStore.isFormValid) {                          
                          //await dadosProdutoStore.salvaProduto();
                          Get.snackbar("Sucesso", "Produto salvo com sucesso!");   
                          produtoStore.resetForm();                                  
                        } else {                                                                         
                          Get.snackbar("Erro", "Por favor, corrija os erros no formulário.");
                        }
                      },                      
                      label: Text('Salvar'),
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