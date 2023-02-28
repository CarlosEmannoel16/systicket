import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:systikcet/models/route.dart';
import 'package:systikcet/models/user.dart';
import 'package:systikcet/pages/usuario_form.dart';

import '../api_client.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserClientPage extends StatefulWidget {

  UserClientPage();

  @override
  _UserClientState createState() => _UserClientState();
}

class _UserClientState extends State<UserClientPage> {

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
  List<User> userList = <User>[];
  List<Routes> routeList = <Routes>[];

  void getRoute() async {
    await Client.get("route").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        routeList =
            lista.map((model) => Routes.fromJson(model)).toList();
      });
      // print("dd ${_listClasses}");
    });
    // return _listClasses;
  }
  @override
  void initState() {
    getRoute();
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
        _criarLinhaTable("Vagas/Destino, Saida/Chegada, valor",),
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
      DataColumn(label: Text('Origem/Destino', textAlign: TextAlign.center, style: TextStyle(color: Colors.red),)),
      DataColumn(label: Text('Saida/Chegada')),
      DataColumn(label: Text('Valor')),
      DataColumn(label: Text('')),
    ];
  }
  List<DataRow> _createRows(String listaNomes) {
    return routeList
        .map((route) => DataRow(cells: [
      DataCell(Text("${route.origemName}/${route.destinyName}")),
      DataCell(Text("${route.departure_time}/${route.arrive_time}")),
      DataCell(Text("R\$ ${route.value}")),
      DataCell(Row(children: [
        GestureDetector(
          child:  OutlinedButton(
            onPressed:() => { Alerta(route.id, 1)},
            child: const Text("COMPRAR", style: TextStyle(color: Colors.white,),
            ),
            style: OutlinedButton.styleFrom(
              elevation: 2.0,
              backgroundColor: const Color.fromRGBO(255, 176, 102, 1),
            ),
          ),
//          onTap: () => Alerta(route.id, 2)     //null
//          {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => UsuarioForm(user: user,)))
//          },
        ),
      ],
      )
      )
    ])).toList();
  }
  Alerta(routerId, costumerId){
    print(routerId);
    print(costumerId);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmação de compra"),
          content: Text("Deseja confirmar a compra de sua passagem?"),
          backgroundColor:Color.fromRGBO(255, 254, 254, 1),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed:() => { Navigator.of(context).pop()},
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    elevation: 2.0,
                    backgroundColor: const Color.fromRGBO(255, 99, 99, 1),
                  ),
                ),
                OutlinedButton(
                  onPressed:() async => {
                    await Comprar(routerId, costumerId),
                    Navigator.of(context).pop()
                    // Navigator.of(context).pop()
                  },
                  child: const Text(
                    "Confirmar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    elevation: 2.0,
                    backgroundColor: const Color.fromRGBO(109, 181, 84, 1),
                  ),
                ),
              ],
            )

          ],
        );
      },
    );
  }

  Comprar(router,costumer ) async{
      var  data = json.encode({
        "router_id": router,
        "costumer_id": costumer
      });
      var a = await Client.create(data, "purchase");
      print(a);
//    .then((res) {
//    print(res.body);
//    print(res);
//    })

  }
}
