import 'file:///C:/AndroidStudioProjects/firebase/lib/telas/AbaProtocolos.dart';
import 'file:///C:/AndroidStudioProjects/firebase/lib/telas/AbaContatos.dart';
import 'file:///C:/AndroidStudioProjects/firebase/lib/telas/AbaSintomas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _emailUsuarioLogado = "";
  List<String> itensMenu = ["Deslogar"];

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    setState(() {
      _emailUsuarioLogado = usuarioLogado.email;
    });
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");

  }

  _escolhaMenu(String itemEscolhido){
    switch (itemEscolhido){
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
    print("Item escolhido foi o : " + itemEscolhido);
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROVA"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "Sintomas",
            ),
            Tab(
              text: "Protocolos",
            ),
            Tab(
              text: "CHAT",
            )
          ],
        ),

        actions: <Widget>[
          PopupMenuButton(
              onSelected: _escolhaMenu,
              itemBuilder: (context){
                return itensMenu.map((String item){
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              })
        ],

      ),
      body: TabBarView(
          controller: _tabController,
          children: <Widget>[AbaSintomas(), AbaProtocolos(), AbaContatos()]),
    );
  }
}
