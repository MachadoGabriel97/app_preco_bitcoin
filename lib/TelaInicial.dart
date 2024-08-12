import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});
  
  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String _valor="R\$ 0,00";
  
  Future<void> buscaValorBtc() async {
    String url = "https://blockchain.info/ticker";
    http.Response resposta = await  http.get(Uri.parse(url));
    Map<String,dynamic> valoresRetorno =  json.decode(resposta.body);
    //print(resposta.body);
    // print(valoresRetorno['BRL']['last']);
    NumberFormat formatador = NumberFormat.currency(locale: 'pt_BR',symbol: 'R\$');

    setState(() {
      _valor = formatador.format(valoresRetorno['BRL']['last']);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 60),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("imagens/logo.png",
                  width:  MediaQuery.of(context).size.width > 1000
                      ? MediaQuery.of(context).size.width * 0.40: MediaQuery.of(context).size.width * 0.60 ,
              ),
              Text("${_valor}"),
              ElevatedButton(onPressed: buscaValorBtc, child: Text("Atualizar"))
            ],

          ),
        ),
      ),
    );
  }
}
