import 'package:credit_card_number_validator/credit_card_number_validator.dart';
import 'package:flutter/material.dart';
import 'package:myeventphoto_mobile_client/src/providers/pago_provider.dart';

class PagoPage extends StatefulWidget {
  PagoPage({Key key}) : super(key: key);

  @override
  _PagoPageState createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _mesController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _cvcController = TextEditingController();
  final pagoProvider = PagoProvider();
  // Declare Variables To Store Card Type and Validity
  String cardType;
  bool isValid = false;
  @override
  void initState() {
    super.initState();

    _cardNumberController.addListener(() {
      if (_cardNumberController.text.length == 16) {
        //_agregar10();
        validarTarjeta();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago De Carrito'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Introduzca Numero de Tarjeta',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
              ),
              _iconTarjeta(),
              formInputNumeroTarjeta(),
              Row(
                children: [
                  formInputMes(),
                  formInputYear(),
                  formInputCVC(),
                ],
              ),
              _textValidation(),
              _botonPagar(),
            ],
          )),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _iconTarjeta() {
    return Icon(
      Icons.credit_card_rounded,
      size: 140.0,
      color: Colors.deepOrange[600],
    );
  }

  Widget formInputNumeroTarjeta() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Flexible(
        child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 16,
            controller: _cardNumberController,
            decoration: InputDecoration(
                hintText: 'Card Number',
                hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                border: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ))),
      ),
    );
  }

  Widget formInputMes() {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 2,
            controller: _mesController,
            decoration: InputDecoration(
              hintText: 'Mes MM',
              hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
            )),
      ),
    );
  }

  Widget formInputYear() {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 4,
            controller: _yearController,
            decoration: InputDecoration(
              hintText: 'Año AAAA',
              hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
            )),
      ),
    );
  }

  Widget formInputCVC() {
    return Flexible(
      fit: FlexFit.tight,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 3,
            controller: _cvcController,
            decoration: InputDecoration(
              hintText: 'CVC',
              hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 14.0, horizontal: 7.0),
            )),
      ),
    );
  }

  Widget _textValidation() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: cardType != null
          // Display Card Type and Validity
          ? Text('Tipo de Tarjeta : $cardType \nEs Valido: $isValid',
              style: TextStyle(
                  color: isValid ? Colors.green : Colors.red,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800))
          : Text(' \n '),
    );
  }

  void validarTarjeta() {
    Map<String, dynamic> cardData =
        CreditCardValidator.getCard(_cardNumberController.text);
    setState(() {
      // Set Card Type and Validity
      cardType = cardData[CreditCardValidator.cardType];
      isValid = cardData[CreditCardValidator.isValidCard];
    });
  }

  _botonPagar() {
    return (FloatingActionButton.extended(
      icon: Icon(Icons.monetization_on),
      label: Text('Pagar'),

      backgroundColor: Colors.orange[800],
      elevation: 4,
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: !isValid ? null : efectuarPagoAAPI,
    ));
  }

  void efectuarPagoAAPI() async {
    if (isValid) {
      String transactionId = await pagoProvider.pagar(
          number: int.parse(_cardNumberController.text),
          expMonth: int.parse(_mesController.text),
          expYear: int.parse(_yearController.text),
          cvc: int.parse(_cvcController.text));
      await pagoProvider.procesoLuegoPago(transactionId: transactionId);
      Navigator.popUntil(context, ModalRoute.withName('home'));
      //Navigator.pushNamed(context, '/invitado/pago/fotos');

    }
  }
}
