import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/form_store.dart';

class ClientePfForm extends StatefulWidget {
  final bool isConsulta;
  final Stream<List<Map<String, dynamic>>>? clientStream;

  ClientePfForm({
    Key? key,
    this.isConsulta = false,
    this.clientStream,
  }) : super(key: key);

  @override
  State<ClientePfForm> createState() => _ClientePfFormState();
}

class _ClientePfFormState extends State<ClientePfForm> {
  final formStore = Get.find<FormStore>();
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
                     // onChanged: (value) => widget.isConsulta ? formStore.setField('nome', value) : formStore.filterClients(value),
                      onFieldSubmitted: (_) => formStore.validateField('nome', controllers['nome']!.text),
                      onEditingComplete: () => formStore.validateField('nome', controllers['nome']!.text),
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
                      onChanged: (value) => formStore.setField('cpf', value),
                      onFieldSubmitted: (_) => formStore.validateField('cpf', controllers['cpf']!.text),
                      onEditingComplete: () => formStore.validateField('cpf', controllers['cpf']!.text),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Observer(
                      builder: (_) => DropdownButtonFormField<String>(
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
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: Observer(
                      builder: (_) => DropdownButtonFormField<String>(
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
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 150,
                    child: CustomFormField(
                      controller: controllers['ie'],
                      keyboardType: TextInputType.number,
                      labelText: 'IE',
                      errorText: formStore.formErrors['ie'],
                      onChanged: (value) => formStore.setField('ie', value),
                      onFieldSubmitted: (_) => formStore.validateField('ie', controllers['ie']!.text),
                      onEditingComplete: () => formStore.validateField('ie', controllers['ie']!.text),
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
                      errorText: formStore.formErrors['endereco'],
                      onChanged: (value) => formStore.setField('endereco', value),
                      onFieldSubmitted: (_) => formStore.validateField('endereco', controllers['endereco']!.text),
                      onEditingComplete: () => formStore.validateField('endereco', controllers['endereco']!.text),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 80,
                    child: CustomFormField(
                      controller: controllers['n'],
                      keyboardType: TextInputType.number,
                      labelText: 'Nº',
                      errorText: formStore.formErrors['n'],
                      onChanged: (value) => formStore.setField('n', value),
                      onFieldSubmitted: (_) => formStore.validateField('n', controllers['n']!.text),
                      onEditingComplete: () => formStore.validateField('n', controllers['n']!.text),
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
                      errorText: formStore.formErrors['bairro'],
                      onChanged: (value) => formStore.setField('bairro', value),
                      onFieldSubmitted: (_) => formStore.validateField('bairro', controllers['bairro']!.text),
                      onEditingComplete: () => formStore.validateField('bairro', controllers['bairro']!.text),
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
                      errorText: formStore.formErrors['cep'],
                      onChanged: (value) => formStore.setField('cep', value),
                      onFieldSubmitted: (_) => formStore.validateField('cep', controllers['cep']!.text),
                      onEditingComplete: () => formStore.validateField('cep', controllers['cep']!.text),
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
                      errorText: formStore.formErrors['email'],
                      onChanged: (value) => formStore.setField('email', value),
                      onFieldSubmitted: (_) => formStore.validateField('email', controllers['email']!.text),
                      onEditingComplete: () => formStore.validateField('email', controllers['email']!.text),
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
                      errorText: formStore.formErrors['contato'],
                      onChanged: (value) => formStore.setField('contato', value),
                      onFieldSubmitted: (_) => formStore.validateField('contato', controllers['contato']!.text),
                      onEditingComplete: () => formStore.validateField('contato', controllers['contato']!.text),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: CustomFormField(
                      controller: controllers['numero'],
                      mask: [maskNumero],
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Numero',
                      errorText: formStore.formErrors['numero'],
                      onChanged: (value) => formStore.setField('numero', value),
                      onFieldSubmitted: (_) => formStore.validateField('numero', controllers['numero']!.text),
                      onEditingComplete: () => formStore.validateField('numero', controllers['numero']!.text),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              if (!widget.isConsulta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Observer(
                      builder: (_) => ElevatedButton(
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
                    ),
                    SizedBox(width: 10),
                    Observer(
                      builder: (_) => ElevatedButton(
                        onPressed: () async {
                          formStore.validateAllFields('pf');
                          if (formStore.isFormValid) {
                            log("validou");
                            formStore.salvaCliente();
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
                      ),
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