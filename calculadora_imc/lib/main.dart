import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Calculadora IMC",
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color _colorBackground = Colors.white;
  Color _colorPrimary = Colors.blue;
  Color _colorSecundary = Colors.white;
  bool _darkMode = false;

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _setMode() {
    setState(() {
      _darkMode = (_darkMode) ? false : true;
      _colorBackground = (_darkMode) ? Colors.grey[850] : Colors.white;
      _colorSecundary = (_darkMode) ? Colors.grey[850] : Colors.white;
    });
  }

  void _resetFields() {
    _weightController.text = "";
    _heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.tryParse(_weightController.text);
      double height = double.tryParse(_heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do Peso: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II: ${imc.toStringAsPrecision(3)}";
      } else if (imc >= 39.9) {
        _infoText = "Obesidade Grau III: ${imc.toStringAsPrecision(3)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: _colorSecundary),
        ),
        centerTitle: true,
        backgroundColor: _colorPrimary,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.wb_incandescent,
              color: _colorSecundary,
            ),
            onPressed: _setMode,
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: _colorSecundary,
            ),
            onPressed: _resetFields,
          ),
        ],
      ),
      backgroundColor: _colorBackground,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: _colorPrimary),
              //Peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: _colorPrimary),
                ),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: _colorPrimary,
                  fontSize: 25.0,
                ),
                controller: _weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira seu Peso";
                  }
                },
              ),
              //Altura
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: _colorPrimary),
                ),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: _colorPrimary,
                  fontSize: 25.0,
                ),
                controller: _heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insira sua Altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    color: _colorPrimary,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(
                        color: _colorSecundary,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _colorPrimary,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
