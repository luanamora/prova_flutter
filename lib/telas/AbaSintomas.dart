import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/classes/Sintomas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AbaSintomas extends StatefulWidget {
  @override
  _AbaSintomasState createState() => _AbaSintomasState();
}

class _AbaSintomasState extends State<AbaSintomas> {
  TextEditingController _controlerDescricao = TextEditingController();
  bool _febre = false;
  bool _diarreia = false;
  bool _coriza = false;
  bool _tosse = false;
  bool _espirro = false;
  double temperatura = 34;
  String label = "34";
  String _mensagemErro = "";

  _validaCampos() async {
    String _descricao = _controlerDescricao.text.toString();

    if (_descricao.isNotEmpty) {
      setState(() {
        _mensagemErro = "Cadastrado com Sucesso!";
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser usuarioLogado = await auth.currentUser();

      Sintomas sintomas = Sintomas();
      sintomas.idUsuario = usuarioLogado.uid;
      sintomas.descricao = _descricao;
      sintomas.coriza = _coriza;
      sintomas.tosse = _tosse;
      sintomas.espirro = _espirro;
      sintomas.febre = _febre;
      sintomas.diarreia = _diarreia;
      sintomas.descricao = _descricao;
      sintomas.temperatura = temperatura;

      await _cadastroSintomas(sintomas);
    } else {
      setState(() {
        _mensagemErro = "Por favor descreva oque está sentindo!";
      });
    }
  }

  _cadastroSintomas(Sintomas sintomas) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    db.collection("sistomas").document(sintomas.idUsuario).setData(sintomas.toMap());

    //Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CheckboxListTile(
                    title: Text("Febre"),
                    activeColor: Color(0xff123456),
                    value: _febre,
                    onChanged: (bool valor) {
                      setState(() {
                        _febre = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Diarréia"),
                    activeColor: Color(0xff123456),
                    value: _diarreia,
                    onChanged: (bool valor) {
                      setState(() {
                        _diarreia = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Coriza"),
                    activeColor: Color(0xff123456),
                    value: _coriza,
                    onChanged: (bool valor) {
                      setState(() {
                        _coriza = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Tosse"),
                    activeColor: Color(0xff123456),
                    value: _tosse,
                    onChanged: (bool valor) {
                      setState(() {
                        _tosse = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Espirro"),
                    activeColor: Color(0xff123456),
                    value: _espirro,
                    onChanged: (bool valor) {
                      setState(() {
                        _espirro = valor;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _controlerDescricao,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Descrição",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Slider(
                    value: temperatura,
                    min: 30,
                    max: 45,
                    label: label,
                    divisions: 100,
                    activeColor: Color(0xff123456),
                    inactiveColor: Color(0xff123456),
                    onChanged: (double novoValor){
                      setState(() {
                        temperatura = novoValor;
                        label = novoValor.toString();
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: RaisedButton(
                      child: Text(
                        "Registrar",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        _validaCampos();
                      }),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}