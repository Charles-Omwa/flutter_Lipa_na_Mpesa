import 'package:flutter/material.dart';
import 'package:mpesa/mpesa.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _phone;
  double _amount;
  final TextEditingController _phoneno = new TextEditingController();
  final TextEditingController _amt = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  Mpesa _mpesa = Mpesa(
    clientKey: "",
    clientSecret: "",
    passKey: "",
    initiatorPassword: "",
    environment: "sandbox",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(25),
                child: Form(
                    key: formKey,
                    child: Column(children: <Widget>[

                      new TextField(
                        controller: _phoneno,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: 'Insert M-PESA Number',
                        ),
                        onChanged: (val) {        // (val) is looking at the value in the textbox.
                         _phone = val;
                        },
                      ),
                      SizedBox(
                        height:30,
                      ),
                      new TextField(
                        controller: _amt,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          hintText: 'Insert Amount',
                        ),
                        onChanged: (value) {        // (val) is looking at the value in the textbox.
                          _amount = double.parse(value.toString());
                        },
                      ),

                      SizedBox(
                        height:30,
                      ),

                      RaisedButton(
                        child: Text("PAY"),
                        onPressed: () {
                          _mpesa
                              .lipaNaMpesa(
                            phoneNumber:_phone,
                            amount: _amount,
                            businessShortCode: "174379",
                            callbackUrl: "",
                          )
                              .then((result) {})
                              .catchError((error) {});
                        },
                      ),
                    ]))),
          ),

        ),
      ),
    );
  }
}