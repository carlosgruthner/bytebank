import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
    home: Scaffold(
      body: ListaTransferencia(),
          ),
      ); 
  }

}
      
class FormularioTransferencia extends StatelessWidget{

  final TextEditingController controladorCampoNumeroConta = TextEditingController();
  final TextEditingController controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    appBar: AppBar(title: Text('Criando Transferencia'),),
    body: Column(
      children: [
        Editor(controlador: controladorCampoNumeroConta, 
          rotulo: 'Numero da Conta',
          dica: '00000'),
        
        Editor(controlador: controladorCampoValor,
          rotulo: 'Valor',
          dica: '0.00',
          icone: Icons.monetization_on),
        ElevatedButton(
          onPressed: () => _criaTransferencia(context),
          child: Text("Confirmar"),
        )
      ],
    ));
  }

  void _criaTransferencia(BuildContext context) { 
            final int numeroConta = int.tryParse(
              controladorCampoNumeroConta.text);
            final double valor = double.tryParse(
              controladorCampoValor.text);
            if(numeroConta != null && valor != null) 
             {
              final transferenciaCriada = Transferencia(
                valor, numeroConta);
              Navigator.pop(context, transferenciaCriada);
            }
           }
}

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  const Editor({this.controlador, this.rotulo, this.dica, this.icone});

  
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controlador,
            style: TextStyle(
              fontSize: 24.0
            ),
            decoration: InputDecoration(
              icon: icone != null ? Icon(icone): null,
              labelText: rotulo,
              hintText: dica,
              ),
            keyboardType: TextInputType.number,
          ),
        );
  }
}

class ListaTransferencia extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: AppBar(title: Text('Tranferências'),),
          body: Column(
          children: [
            ItemTransferencia(Transferencia(100.00, 1000)),
            ItemTransferencia(Transferencia(200.00, 1000)),
            ItemTransferencia(Transferencia(300.00, 1000))
          ],
      ),
      floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
              onPressed: () { 
                final Future<Transferencia> future = Navigator.push(context, MaterialPageRoute(builder:(context){
                  return FormularioTransferencia();
                }));
                future.then((transferenciaRecebida){
                  debugPrint('$transferenciaRecebida');
                });
               },
              
            ),
    );
  }
}

class ItemTransferencia extends StatelessWidget{
  final Transferencia _transferencia;
 
  const ItemTransferencia(this._transferencia);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(_transferencia.valor.toString()),
              subtitle: Text(_transferencia.numeroConta.toString()),
            )
          );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;
  Transferencia(this.valor, this.numeroConta);
}