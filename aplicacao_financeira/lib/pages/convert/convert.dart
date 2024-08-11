import 'package:flutter/material.dart';

class Convert extends StatefulWidget{
  final double? dolar, euro, real, bitcoin;

  const Convert(
    this.dolar, 
    this.euro, 
    this.real, 
    this.bitcoin, 
    {super.key}
  );

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert>{
  final dolarController = TextEditingController();
  final euroController = TextEditingController();
  final bitcoinController = TextEditingController();
  final realController = TextEditingController();

  @override
  void dispose() {
    dolarController.dispose();
    euroController.dispose();
    bitcoinController.dispose();
    realController.dispose();
    super.dispose();
  }

  void _realChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double real = double.parse(text);
    dolarController.text = (real / widget.dolar!).toStringAsFixed(2);
    euroController.text = (real / widget.euro!).toStringAsFixed(2);
    bitcoinController.text = (real / widget.bitcoin!).toStringAsFixed(2);
  }

  void _dolarChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * widget.dolar!).toStringAsFixed(2);
    euroController.text = (dolar * widget.dolar! / widget.euro!).toStringAsFixed(2);
    bitcoinController.text = (dolar * widget.dolar! / widget.bitcoin!).toStringAsFixed(2);
  }

  void _euroChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double euro = double.parse(text);
    realController.text = (euro * widget.euro!).toStringAsFixed(2);
    dolarController.text = (euro * widget.euro! / widget.dolar!).toStringAsFixed(2);
    bitcoinController.text = (euro * widget.euro! / widget.bitcoin!).toStringAsFixed(2);
  }

  void _bitcoinChange(String text){
    if (text.isEmpty) {
        _clearAll();
        return;
    }
    double bitcoin = double.parse(text);
    realController.text = (bitcoin * widget.bitcoin!).toStringAsFixed(2);
    dolarController.text = (bitcoin * widget.bitcoin! / widget.dolar!).toStringAsFixed(2);
    euroController.text = (bitcoin * widget.bitcoin! / widget.euro!).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.clear();
    dolarController.clear();
    euroController.clear();
    bitcoinController.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "\$ Conversor de Moedas \$",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 69, 142, 201),
      ),

      body: SingleChildScrollView(
         padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildTextFormField("Reais", "R\$ ", realController, _realChange),
                const Divider(),
                buildTextFormField("Dólar", "US\$ ", dolarController, _dolarChange),
                const Divider(),
                buildTextFormField("Euro", "EUR ", euroController, _euroChange),
                const Divider(),
                buildTextFormField("Bitcoin", "BTC ", bitcoinController, _bitcoinChange),
              ],
          ),
        ),
    );
  }

  Widget buildTextFormField(String label, String prefix, TextEditingController controller, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 64, 80, 107)),
        border: const OutlineInputBorder(),
        prefixText: prefix,
      ),
      style: const TextStyle(color: Color.fromARGB(255, 62, 93, 109), fontSize: 25.0),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }

}