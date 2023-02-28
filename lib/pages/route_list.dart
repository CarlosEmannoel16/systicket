import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:systikcet/api_client.dart';
import 'package:systikcet/models/city.dart';
import 'package:systikcet/models/route.dart';

import 'create_route.dart';

class ListRouter extends StatefulWidget {
  const ListRouter({Key? key}) : super(key: key);

  @override
  State<ListRouter> createState() => _ListRouterState();
}

class _ListRouterState extends State<ListRouter> {
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController _subrotaController = TextEditingController();
  final TextEditingController _horarioSaidaController = TextEditingController();

  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horarioEntradaController =
      TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  String _city =  "aa";
  List<Cities> cities = <Cities>[];
  // ignore: deprecated_member_use
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Rota",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body:
        Container(
          height: 620.0,width: 1300.0,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                          child:  OutlinedButton(
                            onPressed: casdastra,
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
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 250,
                        child: RouteView(),
                      )
                      //RouteView(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )

    );
  }

  Padding paddingInputLeft() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
      padding: const EdgeInsets.all(15.0),
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

  Widget RouteView(){
    return  ListView.builder(itemCount: routeList.length,
      itemBuilder: (context, index) {
      return Card(
        child: Column(children: <Widget>[
          ListTile(
            title: Container(
              child: Row(
                children: [Icon(Icons.location_on,color: Color.fromRGBO(0, 0, 0, 0.21),),Text(routeList[index].origemName),],
              )
            ),
            subtitle: Container(
                child: Row(
                  children: [Icon(Icons.location_on,color: Color.fromRGBO(255, 176, 102, 1),),
                    Text(routeList[index].destinyName),],
                )
            ),
            // trailing: Text(routeList[index].value),
        ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: OutlinedButton(
                  onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRouter(rota: routeList[index],)))
                  },
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

              OutlinedButton(
                onPressed: casdastra,
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
    //  const SizedBox(width: 8),
          ],
          )
        ],
        ),
      );
      },
    );
  }
  casdastra() async {

    var  data = json.encode({
      "origem": _origemController.text,
      "destiny": _destinoController.text,
      "departure_time": _horarioEntradaController.text,
      "arrive_time": _horarioSaidaController.text,
      "value": _valorController.text
    });
    var a = await Client.create(data, "route");
    print(a);
//    .then((res) {
//    print(res.body);
//    print(res);
//    })
  }
}
