import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFiels() {
    weightController.text = "";
    heightController.text = "";

    //ADNER: O setState permite dar rum refresh nos controles da tela
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calculate() {
    //ADNER: O setState permite dar rum refresh nos controles da tela
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed:
                  _resetFiels, //ADNER: Chama a função para limpar os campos
            )
          ],
        ),
        backgroundColor: Colors.white,
        //ADNER: Permite rolagem na tela, pro teclado não sobrepor
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),

          //ADNER: O Form é usado para que seja possível fazer validações
          child: Form(
            key: _formKey,
            child: Column(
              //ADNER: Tenta preencher a largura da tela com o ícone, fica no centro
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  //ADNER: Esse campo controla essa variavel declarada na classe
                  controller: weightController,

                  //ADNER: Recebe o valor que digitou pra validar
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu Peso!";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  //ADNER: Esse campo controla essa variavel declarada na classe
                  controller: heightController,

                  //ADNER: Recebe o valor que digitou pra validar
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura!";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        //ADNER: Chama a função para calcular o IMC
                        onPressed: () {
                          //Só chama se tiver valido
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0)),
                        color: Colors.green,
                      )),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          ),
        ));
  }
}
