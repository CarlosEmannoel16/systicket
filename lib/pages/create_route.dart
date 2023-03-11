import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:systikcet/api_client.dart';
import 'package:systikcet/models/city.dart';

class CreateRouter extends StatefulWidget {
  var rota;
  CreateRouter({Key? key, this.rota }) : super(key: key);

  @override
  State<CreateRouter> createState() => _CreateRouterState();
}

class _CreateRouterState extends State<CreateRouter> {
  final TextEditingController _origemController = TextEditingController();
  final TextEditingController _subrotaController = TextEditingController();
  final TextEditingController _horarioSaidaController = TextEditingController();

  final TextEditingController _destinoController = TextEditingController();
  final TextEditingController _horarioEntradaController =
      TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  var _cityOrigem =  null;
  var _cityDestino =  null;
  List<Cities> cities = <Cities>[];
  // ignore: deprecated_member_use
  List<Cities> _listClasses = <Cities>[];

  getCities() async {
    await Client.get("city").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        _listClasses =
            lista.map((model) => Cities.fromJson(model)).toList();
        // cities.add(lista as City);// = lista;
            //lista.map((model) => City.fromJson(model)).toList();
      });
      print("dd ${_listClasses}");
    });
    return _listClasses;
  }

  loadForEdit() async {
    //print(widget.rota?.id);
    var teste = widget.rota?.id != null ?  true : false;
    //print("ee ${widget.rota}");
    if(teste) {
      setState(()  {
        _cityOrigem = widget.rota.origem.toString();
        _cityDestino = widget.rota.destiny.toString();
        _origemController.text = widget.rota.origem.toString();
        _destinoController.text = widget.rota.destiny.toString();
        _horarioEntradaController.text = widget.rota.departure_time;
        _horarioSaidaController.text = widget.rota.arrive_time;
        _valorController.text = widget.rota.value;
      });
    }
  }
  @override
  void initState() {
    getCities();
    //print(_listClasses[0].name);
//    _city = "AA";
    cities = _listClasses;
    print(cities);
    _listClasses = _listClasses;
    loadForEdit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Criar rota",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(200.0),
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: casdastra,
                  child:  Text(
                    widget.rota != null ? "Atualizar" : "Cadastra" ,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    elevation: 2.0,
                    backgroundColor: const Color.fromRGBO(255, 176, 102, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
               //textFormField(title: "Origem", controller: _origemController),
              DropdownForm("Origem"),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Horário de saida",
              controller: _horarioSaidaController,
            ),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Subrota de rota",
              controller: _subrotaController,
            ),
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
            child: DropdownForm2("Destino"),
            //textFormField(title: "Destino", controller: _destinoController,),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
                title: "Horário de chegada",
                controller: _horarioEntradaController),
          ),
          Container(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textFormField(
              title: "Valor",
              controller: _valorController,
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

  Widget DropdownForm(String hint){
    return DropdownButton(
      value: _cityOrigem != null ? _cityOrigem : null,
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
          _cityOrigem = newValue!;
          print(_cityOrigem);
        });
      },
      items: _listClasses.map((item) {
        print("aa ${item}");
        return DropdownMenuItem(
          value: item.id.toString(),
          child: Text(item.name),
        );
      }).toList(),
    );
  }
  Widget DropdownForm2(String hint){
    return DropdownButton(
      value: _cityDestino != null ? _cityDestino : null,
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
          _cityDestino = newValue!;
          print(_cityDestino);
        });
      },
      items: _listClasses.map((item) {
        print("aa ${item}");
        return DropdownMenuItem(
          value: item.id.toString(),
          child: Text(item.name),
        );
      }).toList(),
    );
  }


  casdastra() async {

    var  data = json.encode({
      "origem": _cityOrigem,
      "destiny": _cityDestino,
      "departure_time": _horarioEntradaController.text,
      "arrive_time": _horarioSaidaController.text,
      "value": _valorController.text
    });
    var action;
    if(widget.rota != null) {
      action = await Client.update(widget.rota.id,data, "route");
    }
    else {
      var a = await Client.create(data, "route");
    }

    print(action);
//    .then((res) {
//    print(res.body);
//    print(res);
//    })
  }
}
