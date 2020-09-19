import 'package:firebase/classes/Conversa.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AbaConversas extends StatefulWidget {
  @override
  _AbaConversasState createState() => _AbaConversasState();
}

class _AbaConversasState extends State<AbaConversas> {
  List<Conversa> listaConversas = [
    Conversa("Médico", "Boa Tarde",
        "https://firebasestorage.googleapis.com/v0/b/fir-694c5.appspot.com/o/perfil%2F1.jpg?alt=media&token=a1f6f329-f4a5-4daa-b674-e114b6b2cb4b"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaConversas.length, //criei a lista
      itemBuilder: (context, indice) {
        Conversa conversa = listaConversas[indice]; //instancieo a conversa e busco os dados baseado no meu indice

        return ListTile(
          contentPadding: EdgeInsets.all(16),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(conversa.caminhoImagem),
          ),
          title: Text(
            conversa.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            conversa.mensagem,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        );
      },
    );
  }
}
