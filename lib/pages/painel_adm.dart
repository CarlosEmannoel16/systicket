import 'package:flutter/material.dart';
import 'package:systikcet/pages/create_route.dart';
import 'package:systikcet/pages/home_client.dart';
import 'package:systikcet/pages/relatorio_home.dart';
import 'package:systikcet/pages/roite_client.dart';
import 'package:systikcet/pages/route_list.dart';
import 'package:systikcet/pages/user_list.dart';

class PainelADM extends StatelessWidget {
  const PainelADM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeBox = 100;
    return Scaffold(
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
                  containerConfig(
                    title: "Adicionar nova rota",
                    icon: Icons.directions_bus_filled_sharp,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  CreateRouter(),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Ver rotas",
                    icon: Icons.route,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ListRouter(),
                        ),
                    )
                  ),
                  Container(
                    width: sizeBox,
                  ),
                  containerConfig(
                    title: "Relatorios",
                    icon: Icons.report,
                    onTap: () =>
//                        Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => UserClientPage(),
//                      ),
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RelatorioHomePage()
                              ,
                            ),
                    ),
                  ),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeClient(),
                        ),
                      );
                    },
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
}
