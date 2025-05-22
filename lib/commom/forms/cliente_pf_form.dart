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
  
  var maskCpf = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskCep = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
  var maskNumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isConsulta){
      dadosStore.obtemClientes();
     // _searchFocusNode.addListener(() {
        // Quando o foco do _searchFocusNode mudar,
        // atualize o estado showSuggestions na DadosStore.
      //  dadosStore.setShowSuggestions(_searchFocusNode.hasFocus);
   //   });
    }
  }
  
  @override
  void dispose() {
    super.dispose();
     if (widget.isConsulta) { // Apenas se o listener foi adicionado
        _searchFocusNode.removeListener(() {
            // A função exata passada para addListener não é necessária aqui,
            // mas se você tivesse armazenado a função do listener em uma variável,
            // você passaria essa variável para removeListener.
            // Neste caso, como a função é anônima, e _searchFocusNode.dispose()
            // geralmente lida com a limpeza de seus listeners internos,
            // apenas o dispose pode ser suficiente. No entanto, para ser explícito:
            // Se você tem uma função nomeada para o listener:
            // _searchFocusNode.removeListener(_minhaFuncaoListener);
            // Para funções anônimas, o dispose é o mais importante.
        });
    }
    _searchFocusNode.dispose(); 
  }

  void resetForm() {
    formStore.resetForm();
    _searchFocusNode.dispose();
    
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
                controller:  formStore.controllerNome,
                labelText: 'Nome',
                foco: _searchFocusNode,
                onChanged: (value) {
                  log('Vai setar o filtro');
                  dadosStore.setFiltro(value);
                  dadosStore.setShowSuggestions(_searchFocusNode.hasFocus);
                  //dadosStore.setShowSuggestions(false);            
                },
              ),
              Observer( 
                builder: (__) {
                  if ( dadosStore.showSuggestions) {
                    return Container(
                      constraints: BoxConstraints(maxHeight: 200),
                      child: ListView.builder(
                        shrinkWrap: true,                      
                        itemCount: dadosStore.listaFiltrada.length,
                        itemBuilder: (contextList, index) { 
                          final cliente = dadosStore.listaFiltrada[index];
                          return ListTile(                          
                            title: Text(cliente['nome'] ?? ''),
                            onTap: () {                              
                              log('Vai selecionar o cliente $cliente');
                              dadosStore.selecionarCliente(cliente);                              
                              dadosStore.setShowSuggestions(false);    
                              _searchFocusNode.unfocus(); 
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
                      controller: formStore.controllerNome,
                      errorText: formStore.formErrors['nome'],
                      labelText: 'Nome',                                       
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
                      controller: formStore.controllerCpf,
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
                      controller: formStore.controllerIe,
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
                      controller: formStore.controllerEndereco,
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
                      controller: formStore.controllerNumero,
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
                      controller: formStore.controllerBairro,
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
                      controller: formStore.controllerCep,
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
                      controller: formStore.controllerEmail,
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
                      controller: formStore.controllerContato,
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
                      controller: formStore.controllerNumeroContato,
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
                      onPressed: formStore.resetForm,
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
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");   
                          formStore.resetForm();                                  
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