import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:systikcet/api_client.dart';
import 'package:systikcet/models/city.dart';
import 'package:systikcet/pages/painel_adm.dart';

class CreateRouter extends StatefulWidget {
  var rota;
  var func;
  CreateRouter({Key? key, this.rota, this.func}) : super(key: key);

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
  var _cityOrigem = null;
  var _cityDestino = null;
  List<Cities> cities = <Cities>[];
  // ignore: deprecated_member_use
  List<Cities> _listClasses = <Cities>[];

  GlobalKey<FormState> _formulario = GlobalKey<FormState>();

  getCities() async {
    await Client.get("city").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        _listClasses = lista.map((model) => Cities.fromJson(model)).toList();
        // cities.add(lista as City);// = lista;
        //lista.map((model) => City.fromJson(model)).toList();
      });
      print("dd ${_listClasses}");
    });
    return _listClasses;
  }

  loadForEdit() async {
    //print(widget.rota?.id);
    var teste = widget.rota?.id != null ? true : false;
    print("ee ${widget.rota.router_id}");
    print("ee ${widget.rota.id}");
    if (teste) {
      setState(() {
        _cityOrigem = widget.rota.origem.toString();
        _cityDestino = widget.rota.destiny.toString();
        _origemController.text = widget.rota.origem.toString();
        _destinoController.text = widget.rota.destiny.toString();
        _horarioEntradaController.text = widget.rota.departure_time;
        _horarioSaidaController.text = widget.rota.arrive_time;
        _valorController.text = widget.rota.value;
        _subrotaController.text = widget.rota.subrota;
      });
    }
  }

  @override
  void initState() {
    getCities();
    cities = _listClasses;
    _listClasses = _listClasses;
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
            if (widget.func != null) await widget.func();
          },
        ),
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
        child: Form(
          key: _formulario,
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
                    child: Text(
                      widget.rota != null ? "Atualizar" : "Cadastra",
                      style: const TextStyle(
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
      ),
    );
  }

  Padding paddingInputLeft() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child:
                //textFormField(title: "Origem", controller: _origemController),
                dropdownForm("Origem"),
          ),
          Container(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: textFormField(
              title: "Horário de saida",
              controller: _horarioSaidaController,
            ),
          ),
          Container(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
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
      padding: const EdgeInsets.all(7.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: dropdownForm2("Destino"),
            //textFormField(title: "Destino", controller: _destinoController,),
          ),
          Container(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: textFormField(
                title: "Horário de chegada",
                controller: _horarioEntradaController),
          ),
          Container(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Esse campo e obrigatório";
        }
      },
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

  Widget dropdownForm(String hint) {
    return DropdownButton(
      value: _cityOrigem,
      hint: Text(
        hint,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      style: const TextStyle(
        color: Color.fromRGBO(255, 176, 102, 1),
        fontSize: 20.0,
      ),
      isExpanded: true,
      underline: Container(
        height: 2,
        color: const Color.fromRGBO(255, 176, 102, 1),
      ),
      onChanged: (newValue) {
        setState(
          () {
            _cityOrigem = newValue!;
          },
        );
      },
      items: _listClasses.map(
        (item) {
          return DropdownMenuItem(
            value: item.id.toString(),
            child: Text(item.name),
          );
        },
      ).toList(),
    );
  }

  Widget dropdownForm2(String hint) {
    return DropdownButton(
      value: _cityDestino,
      hint: Text(
        hint,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      style: const TextStyle(
        color: Color.fromRGBO(255, 176, 102, 1),
        fontSize: 20.0,
      ),
      isExpanded: true,
      underline: Container(
        height: 2,
        color: const Color.fromRGBO(255, 176, 102, 1),
      ),
      onChanged: (newValue) {
        setState(() {
          _cityDestino = newValue!;
        });
      },
      items: _listClasses.map(
        (item) {
          return DropdownMenuItem(
            value: item.id.toString(),
            child: Text(item.name),
          );
        },
      ).toList(),
    );
  }

  casdastra() async {
    if (_formulario.currentState!.validate()) {
      var data = json.encode({
        "origem": _cityOrigem,
        "destiny": _cityDestino,
        "departure_time": _horarioEntradaController.text,
        "arrive_time": _horarioSaidaController.text,
        "value": _valorController.text,
        "router_id": _subrotaController.text
      });
      var action;
      if (widget.rota != null) {
        await Client.update(widget.rota.id, data, "route").then(
          (value) => {showModal("Atualizado com sucesso!")},
        );
      } else {
        await Client.create(data, "route").then(
          (value) => {showModal("Cadastrado com sucesso!")},
        );
        ;
      }
    }
  }

  showModal(
    String content,
  ) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PainelADM(),
                ),
              );
            },
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }
}
