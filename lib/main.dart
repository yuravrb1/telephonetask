import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class PhoneNumberFormatter extends TextInputFormatter {
  PhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!oldValue.text.contains("(") &&
        oldValue.text.length >= 10 &&
        newValue.text.length != oldValue.text.length) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (oldValue.text.length > newValue.text.length) {
      return TextEditingValue(
        text: newValue.text.toString(),
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }

    var newText = newValue.text;
    if (newText.length == 1) newText = "(" + newText;
    if (newText.length == 4) newText = newText + ") ";
    if (newText.length == 9) newText = newText + "-";

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

bool ButtonActive = true;


var _controller = TextEditingController();

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Get Started',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 100.0),
              ),
              TextField(
                textInputAction: TextInputAction.go,
                maxLength: 15,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[PhoneNumberFormatter()],
                controller: _controller,
                decoration: InputDecoration(
                  counterText: '',
                  counterStyle: TextStyle(fontSize: 0),
                  hintText: '(201) 555-0123',
                  helperText: 'Enter your number',
                  suffixIcon: IconButton(
                    onPressed: () => _controller.clear(),
                    icon: const Icon(Icons.close),
                  ),
                ), // Only numbers can be entered
              ),
              Container(
                padding: EdgeInsets.only(left: 250.0),
                child: IconButton(
                  color: Colors.lightBlue,
                  disabledColor: Colors.black12,
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                  onPressed: () {
                    if (PhoneNumberFormatter == 14) {
                      setState(() {
                        ButtonActive = true;
                      });
                    } else {
                      setState(() {
                        ButtonActive = false;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
