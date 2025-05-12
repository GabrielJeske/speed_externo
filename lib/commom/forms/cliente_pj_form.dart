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
    'razaosocial',
    'fantasia',
    'cnpj',
    'email',
    'endereco',
    'bairro',
    'cep',
    'n', 'contato', 'numero', 'contribuinte', 'ie'
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
    for (var campo in controllers.keys) {
      controllers[campo]!.text = '';
    }
  }

  var maskCnpj = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: { "#": RegExp(r'[0-9]') });
  var maskcep = MaskTextInputFormatter(mask: '#####-###', filter: { "#": RegExp(r'[0-9]') });
  var masknumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  

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
                          labelText: 'contribuinte', 
                          border: OutlineInputBorder(),
                          errorText: formStore.formErrors['contribuinte'],
                        ),
                        value: formStore.formValues['contribuinte'] == '' ?  null: formStore.formValues['contribuinte'],
                        items: ['contribuinte', 'Não contribuinte', 'Isento'].map((String value) {
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
                    ),
                  SizedBox(width: 10),
                  SizedBox(
                      width: 150,
                      child: CustomFormField(
                        controller: controllers['ie'],
                        keyboardType: TextInputType.number,                
                        labelText: 'IE', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['ie'],                      
                        onChanged: (value) => formStore.setField('ie', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('ie', controllers['ie']!.text),
                        //onEditingComplete: () => validateStore.validateField('ie', controllers['ie']!.text),
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
                        labelText: 'endereco',
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['endereco'],                        
                        onChanged: (value) => formStore.setField('endereco', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('endereco', controllers['endereco']!.text),
                        //onEditingComplete: () => validateStore.validateField('endereco', controllers['endereco']!.text),
                      ) 
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 80,
                      child: CustomFormField(
                        controller: controllers['n'],
                        keyboardType: TextInputType.number,
                        labelText: 'Nº', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['n'],
                        onChanged: (value) => formStore.setField('n', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('n', controllers['n']!.text),
                        //onEditingComplete: () => validateStore.validateField('n', controllers['n']!.text),
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
                        labelText: 'bairro', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['bairro'],                        
                        onChanged: (value) => formStore.setField('bairro', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('bairro', controllers['bairro']!.text),
                        //onEditingComplete: () => validateStore.validateField('bairro', controllers['bairro']!.text),
                      )  
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120,
                      child: CustomFormField(
                        controller: controllers['cep'],
                        mask: [maskcep],
                        keyboardType: TextInputType.numberWithOptions(),
                        labelText: 'cep', 
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['cep'],                            
                        onChanged: (value) => formStore.setField('cep', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('cep', controllers['cep']!.text),
                        //onEditingComplete: () => validateStore.validateField('cep', controllers['cep']!.text),
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
                        readOnly: widget.isConsulta,
                        errorText: formStore.formErrors['email'],                        
                        onChanged: (value) => formStore.setField('email', value),
                        //onFieldSubmitted: (_) => validateStore.validateField('email', controllers['email']!.text),
                        //onEditingComplete: () => validateStore.validateField('email', controllers['email']!.text),
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
                          readOnly: widget.isConsulta,
                          errorText: formStore.formErrors['contato'],
                         onChanged: (value) => formStore.setField('contato', value),  
                      )  
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: CustomFormField(
                        controller: controllers['numero'],
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
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");
                        } else {
                          Get.snackbar("Erro", "Por favor, corrija os erros no formulário.");
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