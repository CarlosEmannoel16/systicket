import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:systikcet/models/user.dart';
import 'package:systikcet/pages/usuario_form.dart';

import '../api_client.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:motoapp/usuario/usuario_model.dart';

// import '../api.dart';
// import 'package:http/http.dart' as http;

// import '../endereco/endereco_model.dart';

class UserListPage extends StatefulWidget {

  UserListPage();

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  loadForEdit() async {
//    print(widget.id);
//    var teste = widget.id != null ?  true : false;
//    if(teste) {
//      final http.Response responseUser;
//      final http.Response responseEndereco;
//      responseUser = await ToDoAPI.getById("usuario", widget.id);
//      responseEndereco = await ToDoAPI.getById("endereco", widget.endereco_id);
//      var jsonResponse = json.decode(responseUser.body);
//      Usuario u;
//      var usuario =  Usuario.fromJson(jsonResponse);
//
//      var jsonResponseEndereco = json.decode(responseEndereco.body);
//      var endereco =  Endereco.fromJson(jsonResponseEndereco);
//      setState(()  {
//        _nomeController.text = usuario.nome;
//        _sobrenomeController.text = usuario.sobrenome;
//        _emailController.text = usuario.email;
//        _telefoneController.text = usuario.telefone;
//        _senhaController.text = usuario.senha;
//        // _perfilController.text = usuario.perfil;
//        _senhaController.text = usuario.senha;
//
//        _ruaController.text = endereco.rua;
//        _referenciaController.text = endereco.referencia;
//        _bairroController.text = endereco.bairro;
//        _numeroController.text = endereco.numero;
//        _cidadeController.text = endereco.cidade;
//      });
//    }
  }

  _updateUsuario() async{
//    print(widget.endereco_id);
//    var  dadosUsuario = json.encode({
//      'nome': _nomeController.text,
//      'sobrenome': _sobrenomeController.text,
//      'email': _emailController.text,
//      'telefone': _telefoneController.text,
//      'senha': _senhaController.text,
//      'perfil': widget.us['perfil'],
//      'rua': _ruaController.text,
//      'referencia': _referenciaController.text,
//      'bairro': _bairroController.text,
//      'numero': _numeroController.text,
//      'cidade': _cidadeController.text,
//      'endereco_id': widget.endereco_id
//    });
//    ToDoAPI.update(widget.id,dadosUsuario, "usuario").then((res) {
//      print(res.body);
//      print(res);
//    });
//
  }
  List<User> userList = <User>[];

  void getUsers() async {
    Client.get("usuario").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print("rrr ${responseData}");
        Iterable lista = responseData;
        userList =
            lista.map((model) => User.fromJson(model)).toList();
      });
    });
  }
  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          // title: Text("Criar Novo Usuário", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          centerTitle: true,
          backgroundColor:  Color.fromRGBO(70, 168, 177, 1),
          // backgroundColor:  Color.fromRGBO(255, 255, 255, 1),
        ),
        body: SingleChildScrollView(
          child:Container(
              height: 620.0,
              width: 1300.0,
              color: Color.fromRGBO(255, 255, 255, 1),
              padding: EdgeInsets.all(20.0),
//            child: criaTabela(),
              child: Column(
                children: [
                  GestureDetector(
                    child: Text("Adicionar novo usuário"),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UsuarioForm()))
                    ,
                  ),
                  _createDataTable(),
                ],
              )
            // _createDataTable(),
          ),
        )
    );

  }

  criaTabela() {
    return Table(
      defaultColumnWidth: FixedColumnWidth(400.0),
      border: TableBorder(
        /*horizontalInside: BorderSide(
          //color: Colors.black,
         // style: BorderStyle.solid,
         // width: 0.0,
        ),*/
        /*verticalInside: BorderSide(
          //color: Colors.black,
          //style: BorderStyle.solid,
          //width: 1.0,
        ),*/
      ),
      children: [
        _criarLinhaTable("Vagas, Localizado"),
        _criarLinhaTable("${10},${10}km do IF"),
        _criarLinhaTable2(),

        /*_criarLinhaTable("20, Santos, 5"),*/
      ],
    );
  }
  _criarLinhaTable(String listaNomes) {
    var a = ["jose","maria"];
    return TableRow(
      children: listaNomes.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 18.0),
          ),
          padding: EdgeInsets.all(4.0),
        );
      }).toList(),
    );
  }

  _criarLinhaTable2() {
    var a = ["jose","maria"];
    return TableRow(
      children: userList.map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            name.name,
            style: TextStyle(fontSize: 18.0),
          ),
          padding: EdgeInsets.all(4.0),
        );
      }).toList(),

    );
  }


  Container _createDataTable() {
    return Container(
      //width: 700.0,
        child: Center(
          child: DataTable(columns: _createColumns(), rows: _createRows("Vagas, Localizado à")) ,
        )
//        child: DataTable(columns: _createColumns(), rows: _createRows("Vagas, Localizado à")
//      )
    );
  }
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Nome', textAlign: TextAlign.center, style: TextStyle(color: Colors.red),)),
      DataColumn(label: Text('Acões')),
    ];
  }
  List<DataRow> _createRows(String listaNomes) {
    return userList
        .map((user) => DataRow(cells: [
      DataCell(Text(user.name)),
      DataCell(Row(children: [
        GestureDetector(
          child: OutlinedButton(
            onPressed: () =>
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UsuarioForm(user: user,))),
            child: const Text(
              "Editar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: OutlinedButton.styleFrom(
              elevation: 2.0,
              backgroundColor: const Color.fromRGBO(102, 182, 255, 1),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
            child: OutlinedButton(
              onPressed: () => null,
              child: const Text(
                "Excluir",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: OutlinedButton.styleFrom(
                elevation: 2.0,
                backgroundColor: const Color.fromRGBO(255, 99, 99, 1),
              ),

          ),
        ),

      ],
      )
      )
    ]))
        .toList();
  }
}
