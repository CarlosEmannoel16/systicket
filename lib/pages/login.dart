import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:systikcet/pages/painel_adm.dart';
import 'package:systikcet/pages/usuario_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:systikcet/pages/widget/modal_content.dart';
import 'package:systikcet/pages/widget/text_form_field.dart';
import '../auth/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  // Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              color: const Color.fromRGBO(255, 176, 102, 1),
              child: SizedBox(
                width: 600.0,
                height: 600.0,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "lib/kombi-login-reco.jpg",
                        height: 100.0,
                        width: 500.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Center(
                child: SizedBox(
                  width: 400.0,
                  height: 600.0,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 50.0),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 176, 102, 1),
                              fontSize: 64.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormFieldLogin(
                          labelText: "Usuário",
                          controller: _emailController,
                          type: TextInputType.emailAddress,
                        ),
                        TextFormFieldLogin(
                          labelText: "Senha",
                          controller: _passwordController,
                          type: TextInputType.visiblePassword,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              elevation: 2.0,
                              backgroundColor:
                                  const Color.fromRGBO(255, 176, 102, 1),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                if (_emailController.text == "admin" &&
                                    _passwordController.text == "admin") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const PainelADM(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Campos incorretos'),
                                      content:
                                          const Text('Usuario/senha invalido'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                            context,
                                            'Tente novamente',
                                          ),
                                          child: const Text('Tente novamente'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                : const Text(
                                    "ENTRAR",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    Auth auth = Auth();
    final resp = await auth.login(
      _emailController.text,
      _passwordController.text,
    );
    print(resp.statusCode);
    var jsonResponse = json.decode(resp.body);
    if (resp.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(jsonResponse['token']));
      localStorage.setString('user', json.encode(jsonResponse));
      var user = (localStorage.getString('user'));
      return "OK";
    } else {
      return "não ok";
    }
  }
}
