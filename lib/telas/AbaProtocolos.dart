import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/classes/Sintomas.dart';
import 'package:flutter/material.dart';

class AbaProtocolos extends StatefulWidget {
  @override
  _AbaProtocolosState createState() => _AbaProtocolosState();
}

class _AbaProtocolosState extends State<AbaProtocolos> {

  String _idUsuarioLogado;
  String _emailUsuarioLogado;
  List<Sintomas> listaSintomas = List();


  Future<List<Sintomas>> recuperaProtocolos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
    await db.collection("sistomas").getDocuments();


    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      if (dados["email"] == _emailUsuarioLogado) continue;

      Sintomas sintomas = Sintomas();
      sintomas.idUsuario = item.documentID;
      sintomas.temperatura = dados["temperatura"];
      sintomas.febre = dados["febre"];
      sintomas.coriza = dados["coriza"];
      sintomas.diarreia = dados["diarreia"];
      sintomas.descricao = dados["descricao"];
      sintomas.espirro = dados["espirro"];
      sintomas.tosse = dados["tosse"];

      listaSintomas.add(sintomas);
    }

    return listaSintomas;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(listaSintomas.toString()),);
  }
}
