import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/cliente_controller.dart';


class Clientepfcadastro extends StatefulWidget {
  
  const Clientepfcadastro({super.key});

  @override
  State<Clientepfcadastro> createState() => _ClientepfcadastroState();
}

class _ClientepfcadastroState extends State<Clientepfcadastro> {
  final clienteController = Get.find<ClienteController>();
  final dadosCliente = Get.find<ClienteDados>();
  
  var maskCpf = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskCep = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
  var maskNumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    clienteController.resetForm();
  }
  
  @override
  void dispose() {    
    super.dispose();
  }

  void resetForm() {
    clienteController.resetForm();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Observer(
          builder: (_) => Column(
            children: [
              SizedBox(height: 5),                        
              Row(
                children: [                
                  Flexible(             
                    child: CustomFormField(
                      controller: clienteController.controllerFantasia,
                      errorText: clienteController.formErrors[razaosocial],
                      labelText: 'Teste',                                       
                      onChanged: (value) => clienteController.setField(razaosocial, value),                      
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomFormField(
                      controller: clienteController.controllerCnpj,
                      mask: [maskCpf],
                      keyboardType: TextInputType.numberWithOptions(),
                      errorText: clienteController.formErrors[cnpj],
                      labelText: 'CPF',
                      onChanged: (value) => clienteController.setField(cnpj, value),                     
                    ),
                  ),
                  SizedBox(width: 10),
                   Expanded(
                    flex: 5,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Contribuinte',
                        border: OutlineInputBorder(),                        
                      ),
                      value: clienteController.contribuitePadrao,
                      items: [contribuinte1, contribuinte2, contribuinte9].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          clienteController.formErrors[ie]=null;                                        
                          clienteController.setField(contribuinte, newValue.substring(0, 1));                      
                        }
                      },
                      style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [                                   
                  Expanded(
                    flex: 4,
                    child: CustomFormField(
                      controller: clienteController.controllerIe,
                      keyboardType: TextInputType.number,
                      labelText: 'IE',
                      errorText: clienteController.formErrors[ie],                                          
                      onChanged: (value) => clienteController.setField(ie, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: CustomFormField(
                      controller: clienteController.controllerCep,
                      mask: [maskCep],
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Cep',
                      errorText: clienteController.formErrors[cep],
                      onChanged: (value) => clienteController.setField(cep, value),                     
                    ),
                  )
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: CustomFormField(
                      controller: clienteController.controllerEndereco,
                      labelText: 'Endereco',
                      errorText: clienteController.formErrors[endereco],
                      onChanged: (value) => clienteController.setField(endereco, value),                    
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: CustomFormField(
                      controller: clienteController.controllerBairro,
                      labelText: 'Bairro',
                      errorText: clienteController.formErrors[bairro],
                      onChanged: (value) => clienteController.setField(bairro, value),                     
                    ),
                  ),
                ],
              ),              
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: CustomFormField(
                      controller: clienteController.controllerEmail,
                      labelText: 'E-mail',
                      errorText: clienteController.formErrors[email],
                      onChanged: (value) => clienteController.setField(email, value),                     
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomFormField(
                      controller: clienteController.controllerContato,
                      labelText: 'contato',
                      errorText: clienteController.formErrors[contato],
                      onChanged: (value) => clienteController.setField(contato, value),                      
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 6,
                    child: CustomFormField(
                      controller: clienteController.controllerNumeroContato,
                      mask: [maskNumero],
                      keyboardType: TextInputType.numberWithOptions(),
                      labelText: 'Numero',
                      errorText: clienteController.formErrors[numeroContato],
                      onChanged: (value) => clienteController.setField(numeroContato, value),                     
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButtom(
                      onPressed: clienteController.resetForm,                      
                      label: Text('Cancelar'),
                    ),
                    SizedBox(width: 10),
                    CustomButtom(
                      onPressed: () async {
                        clienteController.validateAllFields();
                        if (clienteController.isFormValid) {                        
                         await dadosCliente.salvaCliente();
                          Get.snackbar("Sucesso", "Cliente salvo com sucesso!");   
                          clienteController.resetForm();                                  
                        } else {                                                                        
                          Get.snackbar("Erro", "Por favor, corrija os erros no formulário.");
                        }
                      },                  
                      label: Text('Salvar') ,                    
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