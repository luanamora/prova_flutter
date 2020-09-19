import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/classes/Sintomas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AbaProtocolos extends StatefulWidget {
  @override
  _AbaProtocolosState createState() => _AbaProtocolosState();
}

class _AbaProtocolosState extends State<AbaProtocolos> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;

  Future<List<Sintomas>> _recuperarSintomas() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
    await db.collection("sistomas").getDocuments();

    List<Sintomas> listaSintomas = List();
    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      if (dados["idUsuario"] == _idUsuarioLogado) {
        Sintomas sintomas = Sintomas();
        sintomas.protocolo = item.documentID;
        sintomas.descricao = dados["descricao"];

        listaSintomas.add(sintomas);
      }
    }
    return listaSintomas;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sintomas>>(
      future: _recuperarSintomas(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando sintomas"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice) {
                  List<Sintomas> listaItens = snapshot.data;
                  Sintomas sintomas = listaItens[indice];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/detalhes",
                          arguments: sintomas);
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    title: Text(
                      sintomas.descricao,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  );
                });
            break;
        }
      },
    );
  }
}
