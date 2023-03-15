import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
//import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
//import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:systikcet/models/route.dart';
import 'package:systikcet/models/user.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
//import 'package:pdf_demo/pdf_preview_screen.dart';


import '../api_client.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserClientPage extends StatefulWidget {
  var id;
  UserClientPage({this.id});

  @override
  _UserClientState createState() => _UserClientState();
}

class _UserClientState extends State<UserClientPage> {

  List<User> userList = <User>[];
  List<Routes> routeList = <Routes>[];
  List<Routes> _arrive_time_List = <Routes>[];
  List<Routes> routeByCity = <Routes>[];
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  var id;
  var _arrive_time = null;
  final doc = pw.Document();
  final pdf = pw.Document();
//  Widget pdfView() => PdfView(
//    controller: pdfController,
//  );

  _creatPdf(name, lastName, year) async {
    pdf.addPage(pw.MultiPage(
        build: (pw.Context context) => [
          pw.Table.fromTextArray(data: <List<String>>[
            <String>['Nome', 'Sobrenome', 'Idade'],
            [name, lastName, year]
          ])
        ]));

    //final String dir = (await getApplicationDocumentsDirectory()).path;

//    final String path = '$dir/pdfExample.pdf';
//    final File file = File(path);
//    file.writeAsBytesSync(pdf.save());
//
//    Navigator.of(context).push(MaterialPageRoute(
//        builder: (_) => ViewPdf(
//          path,
//        )));
//  }
}
  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = await File("$documentPath/example.pdf").create();
    pdf.save();
    file.writeAsBytesSync(pdf.save() as Uint8List );
  }

//  Pdf(format){
//    print(format);
//    doc.addPage(pdf.Page(
//        pageFormat: format.a4,
//        build: (pdf.Context context) {
//          return pdf.Center(
//            child: pdf.Text('Hello World'),
//          ); // Center
//        }));
//    return doc.save();
//  }
  void getRoute() async {
    await Client.get("route").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        routeList =
            lista.map((model) => Routes.fromJson(model)).toList();
        _arrive_time_List =
            lista.map((model) => Routes.fromJson(model)).toList();
        routeList.sort((a, b) => a.arrive_time.compareTo(b.arrive_time));
      });
      // print("dd ${_listClasses}");
    });
    // return _listClasses;
  }

  defineMetodo() async {
    var  action = widget.id != null ? getRouteByCity : getRoute;
    action();
  }
  void getRouteByCity() async {
    id = await widget.id;
//    setState(() {
//      id = widget.idCity;
//    });

    print(id);
    await Client.getById("route/city", id:id).then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        routeByCity =
            lista.map((model) => Routes.fromJson(model)).toList();
      });
      // print("dd ${_listClasses}");
    });
    // return _listClasses;
  }
  @override
  void initState() {
    defineMetodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Passagens", style: TextStyle(color: Colors.black),),
          backgroundColor:  Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: paddingInputLeft(),
                      ),
                      Expanded(
                        child: paddingInputRight(),
                      ),
                      Expanded(
//                        child: textFormField(
//                          title: "Hora",
//                          controller: _horaController,
//                        ),
                      child: DropdownForm("Hora"),
                      ),
                      Expanded(
                        child:  SizedBox(
                          height: 50.0,
                          width: 10.0,
                          child: OutlinedButton(
                            onPressed: search,
                            child: const Text(
                              "BUSCAR",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor: const Color.fromRGBO(109, 181, 84, 1),
                            ),
                          ),
                        ),
                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(0.0),
//                        child: textFormField(
//                          title: "Destino",
//                          controller: _destinoController,
//                        ),
//                      ),
                    ],
                  ),
                  widget.id != null ? _createDataTable(routeByCity) :
                  _createDataTable(routeList),
                ],
              )
            // _createDataTable(),
          ),
        )
    );

  }

//  criaTabela() {
//    return Table(
//      defaultColumnWidth: FixedColumnWidth(400.0),
//      border: TableBorder(
//        /*horizontalInside: BorderSide(
//          //color: Colors.black,
//         // style: BorderStyle.solid,
//         // width: 0.0,
//        ),*/
//        /*verticalInside: BorderSide(
//          //color: Colors.black,
//          //style: BorderStyle.solid,
//          //width: 1.0,
//        ),*/
//      ),
//      children: [
//        _criarLinhaTable("Vagas/Destino, Saida/Chegada, valor",),
//        _criarLinhaTable("${10},${10}km do IF"),
//        _criarLinhaTable2(),
//
//        /*_criarLinhaTable("20, Santos, 5"),*/
//      ],
//    );
//  }

//  _criarLinhaTable(String listaNomes) {
//    var a = ["jose","maria"];
//    return TableRow(
//      children: listaNomes.split(',').map((name) {
//        return Container(
//          alignment: Alignment.center,
//          child: Text(
//            name,
//            style: TextStyle(fontSize: 18.0),
//          ),
//          padding: EdgeInsets.all(4.0),
//        );
//      }).toList(),
//    );
//  }

//  _criarLinhaTable2() {
//    var a = ["jose","maria"];
//    return TableRow(
//      children: userList.map((name) {
//        return Container(
//          alignment: Alignment.center,
//          child: Text(
//            name.name,
//            style: TextStyle(fontSize: 18.0),
//          ),
//          padding: EdgeInsets.all(4.0),
//        );
//      }).toList(),
//
//    );
//  }


  Container _createDataTable(List<Routes> routes) {
    return Container(
      //width: 700.0,
        child: Center(
          child: DataTable(columns: _createColumns(), rows: _createRows(routes)) ,
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
  List<DataRow> _createRows(List<Routes> routes) {
    return routes
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
                  onPressed:() async  => {
                     Comprar(routerId, costumerId),
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


  Padding paddingInputLeft() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            textFormField(title: "Origem", controller: _origemController),
            //DropdownForm("Origem", _listClasses, _city),
          ),
        ],
      ),
    );
  }

  Padding paddingInputRight() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Destino",
              controller: _destinoController,
            ),
          ),
        ],
      ),
    );
  }

  TextFormField textFormField({
    required String title,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 15.0,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromRGBO(171, 169, 166, 1)),
          borderRadius: BorderRadius.circular(2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(171, 169, 166, 1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(171, 169, 166, 1),
            width: 2.0,
          ),
        ),
      ),
    );
  }

  Comprar(router,costumer )async{

      var  data = json.encode({
        "router_id": router,
        "costumer_id": costumer
      });
      var a = await Client.create(data, "purchase");
      print(a);

  }

  search() async{
    await Client.getT("route/filter", origem:  _origemController.text,
        destino: _destinoController.text, hora: _arrive_time ).then((response) {
      setState(() {
        print(response.body);
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        routeList =
            lista.map((model) => Routes.fromJson(model)).toList();
//        _arrive_time_List =
//            lista.map((model) => Routes.fromJson(model)).toList();

        _arrive_time_List.sort((a, b) => a.arrive_time.compareTo(b.arrive_time));

      });
      // print("dd ${_listClasses}");
    });
    ///print(a);
  }
  Widget DropdownForm(String hint){
    //print(_arrive_time);
    return DropdownButton(
      value:  _arrive_time != null ? _arrive_time : null,
      hint: Text(
        hint,
        style: TextStyle(
          color: Color.fromRGBO(70, 168, 177, 1),
          fontSize: 20.0,
        ),
      ),
      style: TextStyle(
        color: Color.fromRGBO(70, 168, 177, 1),
        fontSize: 20.0,
      ),
      isExpanded: true,
      underline: Container(
        height: 2,
        color: Color.fromRGBO(70, 168, 177, 1),
      ),
      onChanged: (newValue) {
        print(newValue);
        setState(() {
          _arrive_time = newValue!;
          print(_arrive_time);
        });
      },
      items: _arrive_time_List.map((item) {
        print("aa ${item}");
        return DropdownMenuItem(
          value: item.arrive_time,
          child: Text(item.arrive_time),
        );
      }).toList(),
    );
  }

}
