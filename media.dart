// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Media extends StatefulWidget {
  const Media({super.key});

  @override
  State<Media> createState() => _MediaState();
}

class _MediaState extends State<Media> {
  @override
  TextEditingController _controlaNome = TextEditingController();
  TextEditingController _controlaNota1 = TextEditingController();
  TextEditingController _controlaNota2 = TextEditingController();
  TextEditingController _controlaNota3 = TextEditingController();
  TextEditingController _controlaNota4 = TextEditingController();
  String _resultado = 'Resultado';
  String _situacao = '';
  List<String> _alunos = ['Alunos:'];

  SnackBar snackBar(String _st) {
    return SnackBar(content: Text('Situação: $_st'));
  }

  void _calcula() {
    double total = 0.0;
    total += double.parse(_controlaNota1.text.replaceAll(",", "."));
    total += double.parse(_controlaNota2.text.replaceAll(",", "."));
    total += double.parse(_controlaNota3.text.replaceAll(",", "."));
    total += double.parse(_controlaNota4.text.replaceAll(",", "."));

    double media = total / 4;

    if (media < 6) {
      _situacao = "Reprovado";
    } else {
      _situacao = "Aprovado";
    }

    setState(() {
      print(_resultado);
      _resultado =
          '${_controlaNome.text} obteve média: ${media.toString().replaceAll(".", ",")}';
      ScaffoldMessenger.of(context).showSnackBar(snackBar(_situacao));
      _alunos.add(_resultado);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Média'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            linhaNome(controlaNome: _controlaNome),
            linhaNota(controlaNota: _controlaNota1),
            linhaNota(controlaNota: _controlaNota2),
            linhaNota(controlaNota: _controlaNota3),
            linhaNota(controlaNota: _controlaNota4),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: _calcula,
                      child: const Text('Aperte para calcular a média'))
                ],
              ),
            ),
            Row(
              children: [Text(_resultado)],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _alunos.length,
              itemBuilder: (context, index) =>
                  ListTile(title: Text(_alunos[index])),
            )
          ],
        ),
      ),
    );
  }
}

class linhaNota extends StatelessWidget {
  const linhaNota({
    super.key,
    required TextEditingController controlaNota,
  }) : _controlaNota = controlaNota;

  final TextEditingController _controlaNota;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Nota1:  '),
        SizedBox(
          width: 100,
          child: TextField(
            controller: _controlaNota,
          ),
        )
      ],
    );
  }
}

class linhaNome extends StatelessWidget {
  const linhaNome({
    super.key,
    required TextEditingController controlaNome,
  }) : _controlaNome = controlaNome;

  final TextEditingController _controlaNome;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Nome:  '),
        SizedBox(
          width: 100,
          child: TextField(
            controller: _controlaNome,
          ),
        )
      ],
    );
  }
}
