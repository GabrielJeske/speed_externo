import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/dados_store.dart';
import 'package:speed_externo/stores/form_store.dart';

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
  

  final Map<String, TextEditingController> controllers = {};

  final List<String> campos = [
    'razaosocial', 'fantasia', 'cnpj', 'email_pj', 'endereco_pj', 'bairro_pj', 'cep_pj', 'n_pj', 'contato_pj', 'numero_pj', 'contribuinte_pj', 'ie_pj'
  ];
  
  
  
  @override
  void initState() {
    super.initState();
    for (var campo in campos) {
      controllers[campo] = TextEditingController();

      controllers[campo]!.addListener(() {
        formStore.setField(campo, controllers[campo]!.text);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void resetForm() {
    formStore.resetForm();
    for (var campo in controllers.keys) {
      controllers[campo]!.text = '';
    }
  }

  var maskCnpj = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: { "#": RegExp(r'[0-9]') });
  var maskcep_pj = MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });
  var masknumero_pj = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Observer(builder: (_) =>
             Column(            
              children: [           
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['razaosocial'],
                        errorText: formStore.formErrors['razaosocial'],
                        labelText: 'Razao Social',
                        readOnly: widget.isConsulta,
                        onChanged: (value) => formStore.setField('razaosocial', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('razaosocial', controllers['razaosocial']!.text),
                        //onEditingComplete: () => validateStore.validateField('razaosocial', controllers['razaosocial']!.text),
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['fantasia'],
                        errorText: formStore.formErrors['fantasia'],
                        readOnly: widget.isConsulta,
                        labelText: 'Nome Fantasia',
                        onChanged: (value) => formStore.setField('fantasia', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('fantasia', controllers['fantasia']!.text),
                        //onEditingComplete: () => validateStore.validateField('fantasia', controllers['fantasia']!.text),
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['cnpj'],
                        mask: [maskCnpj],
                        readOnly: widget.isConsulta,
                        keyboardType: TextInputType.numberWithOptions(),                      
                        errorText: formStore.formErrors['cnpj'],
                        labelText: 'CNPJ',                          
                        onChanged: (value) => formStore.setField('cnpj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('cnpj', controllers['cnpj']!.text),
                        //onEditingComplete: () => validateStore.validateField('cnpj', controllers['cnpj']!.text),
                      )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Logadouro', 
                          border: OutlineInputBorder(),
                          errorText: formStore.formErrors['logadouro'],
                        ),
                        value: formStore.formValues['logadouro'] == '' ?  null: formStore.formValues['logadouro'],
                        items: ['Rua', 'Avenida'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null){
                            formStore.setField('logadouro', newValue ?? '');
                          }                   
                        },
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'contribuinte_pj', 
                          border: OutlineInputBorder(),
                          errorText: formStore.formErrors['contribuinte_pj'],
                        ),
                        value: formStore.formValues['contribuinte_pj'] == '' ?  null: formStore.formValues['contribuinte_pj'],
                        items: ['contribuinte_pj', 'Não contribuinte_pj', 'Isento'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null){
                            formStore.setField('contribuinte_pj', newValue ?? '');
                          }                   
                        },
                      )
                    ),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 150,
                      child: CustomFormField(
                        controller: controllers['ie_pj'],
                        keyboardType: TextInputType.number,                
                        labelText: 'IE', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['ie_pj'],                      
                        onChanged: (value) => formStore.setField('ie_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('ie_pj', controllers['ie_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('ie_pj', controllers['ie_pj']!.text),
                      )
                    )  
                    
                  ]            
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['endereco_pj'],                        
                        labelText: 'endereco_pj',
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['endereco_pj'],                        
                        onChanged: (value) => formStore.setField('endereco_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('endereco_pj', controllers['endereco_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('endereco_pj', controllers['endereco_pj']!.text),
                      ) 
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: CustomFormField(
                        controller: controllers['n_pj'],
                        keyboardType: TextInputType.number,
                        labelText: 'Nº', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['n_pj'],
                        onChanged: (value) => formStore.setField('n_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('n_pj', controllers['n_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('n_pj', controllers['n_pj']!.text),
                      )
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['bairro_pj'],                       
                        labelText: 'bairro_pj', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['bairro_pj'],                        
                        onChanged: (value) => formStore.setField('bairro_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('bairro_pj', controllers['bairro_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('bairro_pj', controllers['bairro_pj']!.text),
                      )  
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: CustomFormField(
                        controller: controllers['cep_pj'],
                        mask: [maskcep_pj],
                        keyboardType: TextInputType.numberWithOptions(),
                        labelText: 'cep_pj', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['cep_pj'],                            
                        onChanged: (value) => formStore.setField('cep_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('cep_pj', controllers['cep_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('cep_pj', controllers['cep_pj']!.text),
                      )  
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['email_pj'],                      
                        labelText: 'E-mail', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['email_pj'],                        
                        onChanged: (value) => formStore.setField('email_pj', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('email_pj', controllers['email_pj']!.text),
                        //onEditingComplete: () => validateStore.validateField('email_pj', controllers['email_pj']!.text),
                      )  
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: CustomFormField(                  
                        controller: controllers['contato_pj'],                        
                          labelText: 'contato_pj',
                          readOnly: widget.isConsulta,
                          errorText: formStore.formErrors['contato_pj'],
                         onChanged: (value) => formStore.setField('contato_pj', value),  
                      )  
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['numero_pj'],
                        mask: [masknumero_pj],
                        keyboardType: TextInputType.numberWithOptions(),                        
                          labelText: 'numero_pj',
                          readOnly: widget.isConsulta,
                          errorText: formStore.formErrors['numero_pj'],                        
                          onChanged: (value) => formStore.setField('numero_pj', value),
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
                      onPressed: resetForm,
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
                          dadosStore.salvaCliente();
                          resetForm;
                        } else {
                          log("nao salvou nem validou");
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
      );
  }
}