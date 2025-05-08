import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/dados_store.dart';
import 'package:speed_externo/stores/form_store.dart';


class ClientePfForm extends StatefulWidget {
  final bool isConsulta;

  ClientePfForm({
    Key? key,
    this.isConsulta = false,
  }) : super(key: key);

  @override
  State<ClientePfForm> createState() => _ClientePfFormState();
}

class _ClientePfFormState extends State<ClientePfForm> {
  final formStore = Get.find<FormStore>();
  final dadosStore = Get.find<DadosStore>();
  final Map<String, TextEditingController> controllers = {};
  final List<String> campos = [
    'nome',
    'cpf',
    'email',
    'endereco',
    'bairro',
    'cep',
    'n',
    'contato',
    'numero',
    'contribuinte',
    'ie'
  ];
  var maskCpf = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskCep = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
  var maskNumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    for (var campo in campos) {
      controllers[campo] = TextEditingController();
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
    dispose();
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
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['nome'],
                      errorText: formStore.formErrors['nome'],
                      labelText: 'Nome',
                      readOnly: widget.isConsulta,
                      onChanged: (value) => formStore.setField('nome', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('nome', controllers['nome']!.text),
                      //onEditingComplete: () => validateStore.validateField('nome', controllers['nome']!.text),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: controllers['cpf'],
                      mask: [maskCpf],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: formStore.formErrors['cpf'],
                      labelText: 'CPF',
                       readOnly: widget.isConsulta,
                      onChanged: (value) => formStore.setField('cpf', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('cpf', controllers['cpf']!.text),
                      //onEditingComplete: () => validateStore.validateField('cpf', controllers['cpf']!.text),
                    ),
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
                      value: formStore.formValues['logadouro'] == '' ? null : formStore.formValues['logadouro'],
                      items: ['Rua', 'Avenida'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,                    
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          formStore.setField('logadouro', newValue ?? '');
                        }
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Contribuinte',
                        border: OutlineInputBorder(),
                        errorText: formStore.formErrors['contribuinte'],
                      ),
                      value: formStore.formValues['Contribuinte'] == '' ? null : formStore.formValues['Contribuinte'],
                      items: ['Contribuinte', 'Não Contribuinte', 'Isento'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          formStore.setField('contribuinte', newValue ?? '');
                        }
                      },
                    ),
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
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['endereco'],
                      labelText: 'Endereco',
                       readOnly: widget.isConsulta,
                      errorText: formStore.formErrors['endereco'],
                      onChanged: (value) => formStore.setField('endereco', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('endereco', controllers['endereco']!.text),
                      //onEditingComplete: () => validateStore.validateField('endereco', controllers['endereco']!.text),
                    ),
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
                    ),
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
                      readOnly: widget.isConsulta,
                      errorText: formStore.formErrors['bairro'],
                      onChanged: (value) => formStore.setField('bairro', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('bairro', controllers['bairro']!.text),
                      //onEditingComplete: () => validateStore.validateField('bairro', controllers['bairro']!.text),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 120,
                    child: CustomFormField(
                      controller: controllers['cep'],
                      mask: [maskCep],
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Cep',
                      readOnly: widget.isConsulta,
                      errorText: formStore.formErrors['cep'],
                      onChanged: (value) => formStore.setField('cep', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('cep', controllers['cep']!.text),
                      //onEditingComplete: () => validateStore.validateField('cep', controllers['cep']!.text),
                    ),
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
                    ),
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
                      //onFieldSubmitted: (_) => validateStore.validateField('contato', controllers['contato']!.text),
                      //onEditingComplete: () => validateStore.validateField('contato', controllers['contato']!.text),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['numero'],
                      mask: [maskNumero],
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Numero',
                      readOnly: widget.isConsulta,
                      errorText: formStore.formErrors['numero'],
                      onChanged: (value) => formStore.setField('numero', value),
                      //onFieldSubmitted: (_) => validateStore.validateField('numero', controllers['numero']!.text),
                      //onEditingComplete: () => validateStore.validateField('numero', controllers['numero']!.text),
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
                      onPressed: resetForm,
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
                        formStore.validateAllFields('pf');
                        if (formStore.isFormValid) {
                          log("validou");
                          await dadosStore.salvaCliente();
                           resetForm;
                        } else {
                          log("nao salvou nem validou");
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