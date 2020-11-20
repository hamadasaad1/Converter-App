import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberFrom;

  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
  String _startMeasure;
  String _convertedMeasure;

  final Map<String, int> _measureMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  String _resultMessage;

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  void convert(String from, String to, double value) {
    int mFrom = _measureMap[from];
    int mTO = _measureMap[to];
    var mult = _formulas[mFrom][mTO]; //array 2*2
    var result = mult * value;
    if (result == null) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()}$_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );

    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );
    return MaterialApp(
      title: "Coverter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Coverter"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Spacer(),
                Text("Value"),
                Spacer(),
                Container(
                  child: TextField(
                    style: inputStyle,
                    decoration: InputDecoration(
                        hintText: "Enter You Value need to Convert"),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      //this to convert text to double
                      var vr = double.parse(text);
                      if (vr != null) {
                        setState(() {
                          _numberFrom = vr;
                        });
                      }
                    },
                  ),
                ),
                Spacer(),
                Text(
                  "From",
                  style: labelStyle,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  style: inputStyle,
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasure = value;
                    });
                  },
                  value: _startMeasure,
                ),
                Spacer(),
                Text(
                  'To',
                  style: labelStyle,
                ),
                Spacer(),
                DropdownButton(
                  isExpanded: true, //this to take all the width screen
                  style: inputStyle, //this for style
                  items: _measures.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: inputStyle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertedMeasure = value;
                    });
                  },
                  value: _convertedMeasure,
                ),
                Spacer(
                  flex: 2,
                ),
                RaisedButton(
                    child: Text("Convert"),
                    onPressed: () {
                      if (_startMeasure.isEmpty ||
                          _convertedMeasure.isEmpty ||
                          _numberFrom == 0) {
                        return;
                      } else {
                        convert(_startMeasure, _convertedMeasure, _numberFrom);
                      }
                    }),
                Spacer(
                  flex: 2,
                ),
                Text((_resultMessage == null) ? '' : _resultMessage.toString(),
                    style: labelStyle),
                Spacer(
                  flex: 8,
                ),
              ],
            )),
      ),
    );
  }
}
