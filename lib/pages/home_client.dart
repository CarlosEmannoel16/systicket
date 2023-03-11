import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:systikcet/pages/create_route.dart';
import 'package:systikcet/pages/roite_client.dart';
import 'package:systikcet/pages/route_list.dart';
import 'package:systikcet/pages/user_list.dart';
import 'package:systikcet/api_client.dart';

import '../models/city.dart';
class HomeClient extends StatefulWidget {
  const HomeClient({Key? key}) : super(key: key);

  @override
  State<HomeClient> createState() => _HomeClientState();
}
class _HomeClientState extends State<HomeClient> {
  // const HomeClient({Key? key}) : super(key: key);

  List<Cities> cities = <Cities>[];
  List<Cities> cities2 = <Cities>[];
// var c;
  getCity() async {
    await Client.get("city").then((response) {
      setState(() {
        var responseData = json.decode(response.body);
        print(responseData);
        Iterable lista = responseData;
        cities =
            lista.map((model) => Cities.fromJson(model)).toList();
      });

    });
    //c =cities;
    //return c;
    print(cities);
    // return _listClasses;
  }
  @override
  void initState()  {
    getCity();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double sizeBox = 100;
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: sizeBox,
                  ),
//                  containerConfig(
//                    title: "Adicionar nova rota",
//                    icon: Icons.directions_bus_filled_sharp,
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) =>  CreateRouter(),
//                        ),
//                      );
//                    },
//                  ),
//                  cities.length > 0 ? teste(cities[0].name, cities[0].id) : Container(color: Colors.red,),
//                  Container(
//                    width: sizeBox,
//                  ),
//                  cities.length > 0 ? teste(cities[1].name, cities[1].id) : Container(color: Colors.red,),
//
                  //teste2(),
                  ...[
                    ...cities.map((city) => teste2(city.name,city.id))
                  ],
                  Container(
                    width: sizeBox,
                  ),
//                  containerConfig2(
//                      title: "Cedro",
//                      img:  "lib/Rectangle2.png",
////                      onTap: () => Navigator.push(context,
////                        MaterialPageRoute(builder: (context) => const ListRouter(),
////                        ),
////                      )
//                  ),
//                  Container(
//                    width: sizeBox,
//                  ),
//                  containerConfig(
//                    title: "Relatorios",
//                    icon: Icons.report,
//                    onTap: () => Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => UserClientPage(),
//                      ),
//                    ),
//                  ),
                  Container(
                    width: sizeBox,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Configuração de usuarios",
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserListPage(),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Sair",
                    icon: Icons.exit_to_app,
                    onTap: () {},
                  ),
                  Container(
                    width: sizeBox,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector containerConfig({
    required String title,
    required IconData icon,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 176, 102, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 80,
            ),
          ),
          const Divider(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget containerConfig2({
    required String title,
    required String img,
    // required void Function()? onTap,
  }) {
          return GestureDetector(
            onTap: null, //onTap,
            child: Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 176, 102, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    "lib/Rectangle2.png",
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                const Divider(),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
  }

  teste(String city, int id){
      return Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      child:  Image.asset(
                        "lib/Rectangle2.png",
//                          height: 300.0,
//                          width: 300.0,
                      ),
                      onTap: () =>
                          Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            UserClientPage(id: id,),
                        ),
                      )
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Text(
                          city,
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]
      );

  }

  teste2(String city, int id){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                      child:  Image.asset(
                        "lib/Rectangle2.png",
//                          height: 300.0,
//                          width: 300.0,
                      ),
                      onTap: () =>
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                UserClientPage(id: id,),
                            ),
                          )
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        Text(
                          city,
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ]
      ),
    );

  }
}
