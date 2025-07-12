import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/forms/cliente_pj_form.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/stores/cliente_dados.dart';
import 'package:speed_externo/stores/cliente_controller.dart';


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
  final clienteController = Get.find<ClienteController>();
  final dadosCliente = Get.find<ClienteDados>();
  
  var maskCpf = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  var maskCep = MaskTextInputFormatter(mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});
  var maskNumero = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final FocusNode foco = FocusNode();
  
  

  @override
  void initState() {
    super.initState();
    if (widget.isConsulta){
      dadosCliente.obtemClientes();
      foco.addListener(() {           
        Future.delayed(Duration(milliseconds: 300 ), () {
          dadosCliente.setListaCliente(foco.hasFocus);                     
        });  
     });
    }else if (!widget.isConsulta){
        clienteController.resetForm();
    }
     WidgetsBinding.instance.addPostFrameCallback((_) {
       dadosCliente.setFiltro('');
     });
  }
  
  @override
  void dispose() {    
    super.dispose();
    foco.dispose(); 
  }

  void resetForm() {
    clienteController.resetForm();
    foco.dispose();    
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
              if (widget.isConsulta)
              CustomFormField(
                controller:  clienteController.controllerRazao,
                labelText: 'Nome',
                foco: foco,
                onTap: () {
                  clienteController.resetForm();
                },
                onChanged: (value) {             
                  dadosCliente.setFiltro(value);
                  dadosCliente.setListaCliente(foco.hasFocus);               
                },
              ),
                Observer(
                builder: (__) {
                  if (dadosCliente.exibeListaCliente) {
                  return Container(
                    constraints: BoxConstraints(maxHeight: 200),
                    child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dadosCliente.listaFiltrada.length,
                    itemBuilder: (contextList, index) {
                      final cliente = dadosCliente.listaFiltrada[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                      title: Row(
                        children: [
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Text(cliente.razaosocial ?? '', style: TextStyle(fontSize: 12),),
                        ),                                             
                        SizedBox(width: 10),
                        SizedBox(
                          height: 25,
                          child: VerticalDivider(
                            color: Theme.of(context).colorScheme.outline, // Cor da sua linha (como você já estava a usar)
                            thickness: 2,        // Espessura da sua linha
                            indent: 0,           // Remove qualquer espaçamento em cima
                            endIndent: 0,        // Remove qualquer espaçamento em baixo
                            width: 10,           // Largura que o divisor ocupa na Row (ajuste se precisar de mais espaço lateral)
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: Text(cliente.fantasia ?? '', style: TextStyle(fontSize: 12),),
                        ),
                        ],
                      ),
                      onTap: () {                                                
                        dadosCliente.selecionarCliente(cliente); // <--- Isso já atualiza o cliente no store
                        dadosCliente.setListaCliente(false); // Esconde a lista de sugestões
                        foco.unfocus(); // Remove o foco do campo
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
                      controller: clienteController.controllerFantasia,
                      errorText: clienteController.formErrors[razaosocial],
                      labelText: 'Nome',                                       
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
                       readOnly: widget.isConsulta,
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
                      onChanged: widget.isConsulta ? null : (String? newValue) {
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
                      readOnly: widget.isConsulta,                   
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
                      readOnly: widget.isConsulta,
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
                       readOnly: widget.isConsulta,
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
                      readOnly: widget.isConsulta,
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
                      readOnly: widget.isConsulta,
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
                      readOnly: widget.isConsulta,
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
                      readOnly: widget.isConsulta,
                      errorText: clienteController.formErrors[numeroContato],
                      onChanged: (value) => clienteController.setField(numeroContato, value),                     
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              if (!widget.isConsulta)
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