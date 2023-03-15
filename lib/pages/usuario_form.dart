import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import '../api_client.dart';
import '../models/user.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({Key? key, this.user, this.func}) : super(key: key);

  final user;
  final func;

  @override
  _UsuarioFormState createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _dataNascimentoController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _sexoController = TextEditingController();

  GlobalKey<FormState> _formulario = GlobalKey<FormState>();
  GlobalKey<FormState> _formulario2 = GlobalKey<FormState>();
  GlobalKey<FormState> _formulario3 = GlobalKey<FormState>();
  GlobalKey<FormState> _formulario4 = GlobalKey<FormState>();
  GlobalKey<FormState> _formulario5 = GlobalKey<FormState>();

  late String data;
  late String _sexo;
  // var formatoDataNascimento =  MaskTextInputFormatter(mask: '##/##/####', filter: { "#": RegExp(r'[0-9]') });
  // var formatoTelefone =  MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  Future _postUsuario() async {
    //  var p = widget.perfil &&  widget.perfil == "ADMIN" ? "ADMIN" : widget.perfil;
    var dadosUsuario = json.encode({
      'name': _nomeController.text,
      'email': _emailController.text,
      'password': _senhaController.text,
      'phone': _telefoneController.text,
      'type': "adm",
      'forget': "N"
    });
    var a = await Client.create(dadosUsuario, "usuario");
//    .then((res) {
//    print(res.body);
//    print(res);
//    })
  }

  loadForEdit() async {
    var teste = widget.user?.id != null ? true : false;
    if (teste) {
      setState(() {
        _nomeController.text = widget.user.name;
        _emailController.text = widget.user.email;
        _telefoneController.text = widget.user.phone;
        _senhaController.text = widget.user.password;
      });
    }
  }

  _updateUsuario() async {
    var data = json.encode({
      'name': _nomeController.text,
      'email': _emailController.text,
      'password': _senhaController.text,
      'phone': _telefoneController.text,
    });
    Client.update(widget.user.id, data, "usuario").then((res) {
      print(res.body);
      print(res);
    });
  }

  @override
  void initState() {
    loadForEdit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            Navigator.of(context).pop();
            await widget.func();
          },
        ),
        title: const Text(
          "Criar Novo Usuário",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(70, 168, 177, 1),
        // backgroundColor:  Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 620.0,
          color: const Color.fromRGBO(255, 255, 255, 1),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200.0,
                height: 100.0,
                child: Form(
                  key: _formulario,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: [
                          formT(
                            200,
                            50,
                            _nomeController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Nome',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          formT(
                            200.0,
                            50.0,
                            _telefoneController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Telefone',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
//                    Column(
//                      children: [
//                        FormT(200,50,_cpfController, TextInputType.text, "Antônio Carlos",
//                            'CPF',
//                            Colors.blue,25.0
//                        )
//                      ],
//                    ),
                    ],
                  ),
                ),
              ),
//              SizedBox(
//                  width: 200.0,
//                  height: 100.0, child:  Form(key: _formulario2,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Column(
//                        children: [
//                          FormT(200.0,50.0,_dataNascimentoController, TextInputType.text, "Antônio Carlos",
//                              'Data de Nascimento',
//                              Colors.blue,25.0
//                          )
//                        ],
//                      ),
//                      Column(
//                        children: [
//                          FormT(200.0,50.0,_sexoController, TextInputType.text, "Antônio Carlos",
//                              'Sexo',
//                              Colors.blue,25.0
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                ),
              SizedBox(
                width: 200.0,
                height: 100.0,
                child: Form(
                  key: _formulario3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//                      Column(
//                        children: [
//                          FormT(200.0,50.0,_telefoneController, TextInputType.text, "Antônio Carlos",
//                              'Telefone',
//                              Colors.blue,25.0
//                          )
//                        ],
//                      ),
                      Column(
                        children: [
                          formT(
                            200.0,
                            50.0,
                            _emailController,
                            TextInputType.text,
                            "Antônio Carlos",
                            'Email',
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          formT(
                            200.0,
                            50.0,
                            _senhaController,
                            TextInputType.text,
                            "Antônio Carlos",
                            "Senha",
                            Colors.blue,
                            25.0,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
//              SizedBox(
//                  width: 200.0,
//                  height: 100.0, child:  Form(key: _formulario4,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Column(
//                        children: [
//                          FormT(200.0,50.0,_loginController, TextInputType.text, "Antônio Carlos",
//                              'Login',
//                              Colors.blue,25.0
//                          )
//                        ],
//                      ),
//                      Column(
//                        children: [
//                          FormT(200.0,50.0,_senhaController, TextInputType.text, "Antônio Carlos",
//                              "Senha",
//                              Colors.blue,25.0
//                          )
//                        ],
//                      ),
//                    ],
//                  ),
//                ),
//                ),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 10.0,
                    left: 400.0,
                    right: 400.0,
                  ),
                  child: SizedBox(
                    height: 50.0,
                    width: 10.0,
                    child: OutlinedButton(
                      child: Text(
                        widget.user?.id != null ? "ATUALIZAR" : "CADASTRAR",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        elevation: 2.0,
                        backgroundColor: const Color.fromRGBO(255, 176, 102, 1),
                      ),
                      onPressed: () async {
                        if (_formulario.currentState!.validate()) {
                          var action = widget.user != null
                              ? _updateUsuario
                              : _postUsuario;
                          await action();
//                            var _resultado = await action();
//                            //Navigator.pop(context);
//                            print(_resultado);
//                            if(_resultado == "aprovado"){
//                              print(_resultado);
//                              // Navigator.push(context, MaterialPageRoute(builder: (context) => DadosAcademico(id: widget.id,)) );
//                            }
//                            else{
//                              Alerta();
//                            }
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  alerta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ERRO"),
          content: const Text("ERRO AO SALVAR DADOS, TENTE NOVAMENTE"),
          backgroundColor: const Color.fromRGBO(70, 168, 177, 1),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget formT(
    double width,
    double height,
    controle,
    typeInput,
    String hint,
    String label,
    font,
    color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
      child: SizedBox(
        width: width,
        height: height,
        child: TextFormField(
          controller: controle,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 25.0,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "CAMPO OBRIGATÓRIO";
            }
            return null;
          },
        ),
      ),
    );
  }
}
