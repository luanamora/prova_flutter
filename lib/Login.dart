import 'package:firebase/classes/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos() {
    String email = _controllerEmail.text.toString();
    String senha = _controllerSenha.text.toString();

    if (email.isNotEmpty) {
      if (senha.isNotEmpty) {
        setState(() {
          _mensagemErro = "Login sucesso!";
        });

        Usuario usuario = Usuario();
        usuario.carteiraSus = email;
        usuario.senha = senha;

        _autenticandoUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Favor preencher a senha!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Favor preencher a carteira do SUS!";
      });
    }
  }

  _autenticandoUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
        email: usuario.carteiraSus, password: usuario.senha)
        .then((firebaserUser) {
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((error) {
      setState(() {
        _mensagemErro = "Erro au autenticar o usuário!" + error.toString();
      });
    });
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    auth.signOut(); //verificou que o usuário está logado, faça o logoff

    if (usuarioLogado != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff123456)),
        padding: EdgeInsets.all(18),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/hospital.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Login",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    obscureText: true,
                    controller: _controllerSenha,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _validarCampos();
                      }),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não possui conta? Cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/cadastro");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
