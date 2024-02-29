import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TelaBtc extends StatefulWidget {
  const TelaBtc({Key? key}) : super(key: key);

  @override
  State<TelaBtc> createState() => _TelaBtcState();
}

class _TelaBtcState extends State<TelaBtc> {
  String _preco = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = jsonDecode(response.body);
    double valor = retorno["BRL"]["buy"];
    NumberFormat formato = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    setState(() {
      _preco = formato.format(valor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  _preco,
                  style: TextStyle(color: Colors.green, fontSize: 35),
                ),
              ),
              ElevatedButton(
                onPressed: _recuperarPreco,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Cor de fundo
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cor do texto (Cor do primeiro plano)
                  fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(250)), // Define a largura do botão
                ),
                child: Text(
                  "Atualização",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
