import 'package:flutter/material.dart';

class Convert extends StatefulWidget{
  final double dolar, euro, real, bitcoin;

  Convert(this.dolar, this.euro, this.real, this.bitcoin);

  @override
  _ConvertState createState() => _ConvertState(dolar, euro, real, bitcoin);
}

class _ConvertState extends State<Convert>{
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final bitcoinController = TextEditingController();
  final realController = TextEditingController();

  final double dolar, euro, real, bitcoin;

  _ConvertState(this.dolar, this.euro, this.real, this.bitcoin);

  void _realChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    bitcoinController.text = (real / bitcoin).toStringAsFixed(2);
  }

  void _dolarChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    bitcoinController.text = (dolar * this.dolar / bitcoin).toStringAsFixed(2);
  }

  void _euroChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    bitcoinController.text = (euro * this.euro / bitcoin).toStringAsFixed(2);
  }

  void _bitcoinChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * this.bitcoin).toStringAsFixed(2);
    dolarController.text = (bitcoin * this.bitcoin / dolar).toStringAsFixed(2);
    euroController.text = (bitcoin * this.bitcoin / euro).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
    bitcoinController.text = "";
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("\$ Conversor de Moedas \$"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
         padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTextFormField(
                  "Reais", "R\$ ", realController, _realChange),
                const Divider(),
                buildTextFormField(
                  "Dólar", "US\$ ", dolarController, _dolarChange),
                const Divider(),
                buildTextFormField(
                  "Euro", "EUR ", euroController, _euroChange),
                const Divider(),
                buildTextFormField(
                  "Bitcoin", "BTC ", bitcoinController, _bitcoinChange),
              ],
          ),
        ),
    );
  }

  Widget buildTextFormField(String label, String prefix, TextEditingController controller, Function f){
    return TextField(
      onChanged:(value) => f(value),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blueAccent),
        border: const OutlineInputBorder(),
        prefixText: "$prefix",
      ),
      style: const TextStyle(color: Colors.blueGrey, fontSize: 25.0),
       keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

}