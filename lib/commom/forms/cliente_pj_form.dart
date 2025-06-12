import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/cliente_controller.dart';

class ClientePjForm extends StatefulWidget {
  
  final bool isConsulta;

  const ClientePjForm({
    Key? key,
    this.isConsulta = false,
  }) : super(key: key);

  @override
  State<ClientePjForm> createState() => _ClientePjFormState();
}

class _ClientePjFormState extends State<ClientePjForm> {
  final formStore = Get.find<FormStore>();
  final dadosStore = Get.find<DadosStore>();

  final FocusNode foco = FocusNode();
  
  @override
  void initState() {
    super.initState();
    if (widget.isConsulta){
      dadosStore.obtemClientes();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosStore.setListaCliente(foco.hasFocus);                     
        });  
     });
    }
     WidgetsBinding.instance.addPostFrameCallback((_) {
       formStore.resetForm();
       dadosStore.setFiltro('');
     });
  }
  
  @override
  void dispose() {    
    super.dispose();
    foco.dispose(); 
  }

  void resetForm() {
    formStore.resetForm();
    foco.dispose();    
  }


  var maskCnpj = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: { "#": RegExp(r'[0-9]') });
  var maskcep = MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });
  var masknumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(constraints: BoxConstraints(
            minHeight: constraints.maxHeight
          ),
          child: IntrinsicHeight(
            child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Observer(builder: (_) =>
             Column(            
              children: [           
                SizedBox(height: 5),
                if (widget.isConsulta)          
                    CustomFormField(
                      controller:  formStore.controllerRazao,
                      labelText: 'Razao Social',
                      foco: foco,
                      onChanged: (value) {
                        log('Vai setar o filtro');
                        dadosStore.setFiltro(value);
                        dadosStore.setListaCliente(foco.hasFocus);                      
                      },
                    ),
                    Observer( 
                      builder: (__) {
                        if ( dadosStore.exibeListaCliente) {
                          return Container(
                            constraints: BoxConstraints(maxHeight: 200),
                            child: ListView.builder(
                              shrinkWrap: true,                      
                              itemCount: dadosStore.listaFiltrada.length,
                              itemBuilder: (contextList, index) { 
                                final cliente = dadosStore.listaFiltrada[index];
                                return ListTile(                          
                                  title: Text(cliente.razaosocial ?? ''),
                                  onTap: () {                              
                                    log('Vai selecionar o cliente $cliente');
                                    dadosStore.selecionarCliente(cliente, 'pj');                              
                                    dadosStore.setListaCliente(false);    
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
                        controller: formStore.controllerRazao,
                        errorText: formStore.formErrors['razaosocial'],
                        labelText: 'Razao Social',
                        readOnly: widget.isConsulta,
                        onChanged: (value) => formStore.setField('razaosocial', value),                        
                      )
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: formStore.controllerFantasia,
                        errorText: formStore.formErrors['fantasia'],
                        readOnly: widget.isConsulta,
                        labelText: 'Nome Fantasia',
                        onChanged: (value) => formStore.setField('fantasia', value),                        
                      )
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomFormField(
                        controller: formStore.controllerCnpj,
                        mask: [maskCnpj],
                        readOnly: widget.isConsulta,
                        keyboardType: TextInputType.numberWithOptions(),                      
                        errorText: formStore.formErrors['cnpj'],
                        labelText: 'CNPJ',                          
                        onChanged: (value) => formStore.setField('cnpj', value),
                       )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 4,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(                        
                          labelText: 'Logadouro', 
                          border: OutlineInputBorder(),
                          errorText: formStore.formErrors['logadouro'],
                        ),
                        value: formStore.cliente.logadouro == '' ?  null: formStore.cliente.logadouro,
                        items: ['Rua', 'Avenida'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null){
                            formStore.setField('logadouro', newValue);
                          }                   
                        },
                      )
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                     Expanded(
                      flex: 7,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Contribuinte',
                        border: OutlineInputBorder(),
                        errorText: formStore.formErrors['contribuinte'],
                      ),
                      value: formStore.cliente.contribuinte == '' ? null : formStore.cliente.contribuinte,
                      items: ['Contribuinte', 'Não Contribuinte', 'Isento'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          formStore.setField('contribuinte', newValue );
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      flex: 6,
                      child: CustomFormField(
                        controller: formStore.controllerIe,
                        keyboardType: TextInputType.number,                
                        labelText: 'IE', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['ie'],                      
                        onChanged: (value) => formStore.setField('ie', value),
                        )
                    )                      
                  ]            
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: CustomFormField(
                        controller: formStore.controllerEndereco,                        
                        labelText: 'endereco',
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['endereco'],                        
                        onChanged: (value) => formStore.setField('endereco', value),                        
                      ) 
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: CustomFormField(
                        controller: formStore.controllerNumero,
                        keyboardType: TextInputType.number,
                        labelText: 'Nº', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['n'],
                        onChanged: (value) => formStore.setField('n', value),
                      )
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: CustomFormField(
                        controller: formStore.controllerBairro,                       
                        labelText: 'bairro', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['bairro'],                        
                        onChanged: (value) => formStore.setField('bairro', value),
                       )  
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: CustomFormField(
                        controller: formStore.controllerCep,
                        mask: [maskcep],
                        keyboardType: TextInputType.numberWithOptions(),
                        labelText: 'cep', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['cep'],                            
                        onChanged: (value) => formStore.setField('cep', value),
                        )  
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: formStore.controllerEmail,                      
                        labelText: 'E-mail', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['email'],                        
                        onChanged: (value) => formStore.setField('email', value),
                        )  
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CustomFormField(                  
                        controller: formStore.controllerContato,                        
                          labelText: 'contato',
                          readOnly: widget.isConsulta,
                          errorText: formStore.formErrors['contato'],
                         onChanged: (value) => formStore.setField('contato', value),  
                      )  
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 6,
                      child: CustomFormField(
                        controller: formStore.controllerNumeroContato,
                        mask: [masknumero],
                        keyboardType: TextInputType.numberWithOptions(),                        
                          labelText: 'numero',
                          readOnly: widget.isConsulta,
                          errorText: formStore.formErrors['numero'],                        
                          onChanged: (value) => formStore.setField('numero', value),
                      )  
                    )
                  ],
                ),
                SizedBox(height: 30),
                if (!widget.isConsulta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: formStore.resetForm,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(15),
                          foregroundColor: Colors.black,
                          textStyle: TextStyle(
                            fontSize: 20,
                          )
                      ),
                      child: Text('CANCELAR'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        formStore.validateAllFields('pj');
                        if (formStore.isFormValid) {
                          log("validou");
                          await dadosStore.salvaCliente();
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");   
                          formStore.resetForm();                                  
                        } else {                                                  
                          log("nao salvou nem validou");
                          Get.snackbar("Erro", "Por favor, corrija os erros no formulário.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        padding: EdgeInsets.all(15),
                        foregroundColor: Colors.black,
                        textStyle: TextStyle(fontSize: 20)
                      ),
                      child: Text('SALVAR')
                    )  
                  ],
                ),
              ],
            ),
          ),
        ),
      )
          ),
          ),
        );
    },);
  }
}