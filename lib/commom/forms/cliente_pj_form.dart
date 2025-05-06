import 'dart:developer';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/form_store.dart';

class ClientePjForm extends StatefulWidget {
  const ClientePjForm({super.key});

  @override
  State<ClientePjForm> createState() => _ClientePjFormState();
}

class _ClientePjFormState extends State<ClientePjForm> {
  final formStore = Get.find<FormStore>();
  
  // Criando um Map para armazenar os controladores de cada campo
  final Map<String, TextEditingController> controllers = {};

  final List<String> campos = [
    'razaosocial', 'fantasia', 'cnpj', 'email', 'endereco', 'bairro', 'cep', 'n', 'contato', 'numero', 'contribuinte', 'ie'
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
  var maskCep = MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });
  var maskNumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(            
            children: [           
              SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['razaosocial'],
                        errorText: formStore.formErrors['razaosocial'],
                        labelText: 'Razao Social'
                     // onChanged: (value) => formStore.setField('nome', value),
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
                        labelText: 'Nome Fantasia'
                     // onChanged: (value) => formStore.setField('nome', value),
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
                      keyboardType: TextInputType.numberWithOptions(),                      
                      errorText: formStore.formErrors['cnpj'],
                      labelText: 'CNPJ'                          
                      //onChanged: (value) => formStore.setField('cpf', value)
                    )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Observer(builder: (_) =>
                      DropdownButtonFormField<String>(
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
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Observer(builder: (_) =>
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Contribuinte', 
                          border: OutlineInputBorder(),
                          errorText: formStore.formErrors['contribuinte'],
                        ),
                        value: formStore.formValues['Contribuinte'] == '' ?  null: formStore.formValues['Contribuinte'],
                        items: ['Contribuinte', 'Não Contribuinte', 'Isento'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null){
                            formStore.setField('contribuinte', newValue ?? '');
                          }                   
                        },
                      )
                    )
                  ),
                SizedBox(width: 10),
                SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: controllers['ie'],
                      keyboardType: TextInputType.number,                
                          labelText: 'IE', 
                          errorText: formStore.formErrors['ie']                      
                      //onChanged: (value) => formStore.setField('n', value),
                    )
                  )  
                  
                ]            
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['endereco'],                        
                        labelText: 'Endereco',
                        errorText: formStore.formErrors['endereco']                        
                      //onChanged: (value) => formStore.setField('endereco', value),
                    ) 
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: CustomFormField(
                      controller: controllers['n'],
                      keyboardType: TextInputType.number,
                          labelText: 'Nº', 
                          errorText: formStore.formErrors['n']
                      //onChanged: (value) => formStore.setField('n', value),
                    )
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['bairro'],                       
                        labelText: 'Bairro', 
                        errorText: formStore.formErrors['bairro']                        
                       // onChanged: (value) => formStore.setField('bairro', value),
                    )  
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    child: CustomFormField(
                      controller: controllers['cep'],
                      mask: [maskCep],
                      keyboardType: TextInputType.numberWithOptions(),
                          labelText: 'Cep', 
                          errorText: formStore.formErrors['cep']                            
                        //  onChanged: (value) => formStore.setField('cep', value),
                    )  
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['email'],                      
                          labelText: 'E-mail', 
                          errorText: formStore.formErrors['email']                        
                    //  onChanged: (value) => formStore.setField('email', value),
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
                      controller: controllers['contato'],                        
                        labelText: 'contato',
                        errorText: formStore.formErrors['contato']                        
                     // onChanged: (value) => formStore.setField('contato', value),  
                    )  
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['numero'],
                      mask: [maskNumero],
                      keyboardType: TextInputType.numberWithOptions(),                        
                        labelText: 'Numero',
                        errorText: formStore.formErrors['numero']                        
                     // onChanged: (value) => formStore.setField('numero', value),
                    )  
                  )
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Observer(builder: (_) => 
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
                  ),
                  SizedBox(width: 10),
                  Observer(builder: (_) =>
                    ElevatedButton(
                       onPressed: () {
                        formStore.validateAllFields();
                        if (formStore.isFormValid) {
                          log("salvou");
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
                  )  
                ],
              ),
            ],
          ),
        ),
      );
  }
}