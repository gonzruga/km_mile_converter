import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'KM-Mile Converter',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'KILOMETER MILE CONVERTER',
            ),
          ),
          body: HomeScreen(),
        ));
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextStyle labelStyle = TextStyle(
    color: Colors.blue,
    fontSize: 20.0,
  );
  final TextStyle resultSyle = TextStyle(
    color: Colors.red,
    fontSize: 30.0,
    fontWeight: FontWeight.w700,
  );

  final List<String> _mesaures = [
    'Kilometers',
    'Miles'
  ];

  double _value;
  String _fromMesaures = 'Kilometers';
  String _toMesaures = 'Miles';
  String _results = "";

  final Map<String, int> _mesauresMap = {
    'Kilometers': 0,
    'Miles': 1,

  };

  dynamic _conversionMultipliers = {
    '0': [1, 0.621371],
    '1': [1.60934, 1],

  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            //  INPUT VALUE
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter the value of unit you wish to convert from:',
              ),
              onChanged: (value) {
                setState(() {
                  _value = double.parse(value);
                });
              },
            ),
            SizedBox(height: 30.0),

            //  CONVERTING UNITS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'FROM',
                      style: labelStyle,
                    ),
                    DropdownButton(
                      items: _mesaures
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _fromMesaures = value;
                        });
                      },
                      value: _fromMesaures,
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('TO', style: labelStyle),
                    DropdownButton(
                      items: _mesaures
                          .map((String value) => DropdownMenuItem<String>(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _toMesaures = value;
                        });
                      },
                      value: _toMesaures,
                    )
                  ],
                ),
              ],
            ),



            // CONVERTING
            MaterialButton(
              minWidth: double.infinity,
              onPressed: _convert,
              child: Text(
                'CONVERT',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 25.0),
            Text(
              _results,
              style: resultSyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Conversion and Display
  void _convert() {
    print('Button Pressed');
    print(_value);

    if (_value != 0 && _fromMesaures.isNotEmpty && _toMesaures.isNotEmpty) {
      int from = _mesauresMap[_fromMesaures];
      int to = _mesauresMap[_toMesaures];

      var multiplier = _conversionMultipliers[from.toString()][to];

      setState(() {
        _results =
            "$_value $_fromMesaures = ${_value * multiplier} $_toMesaures";
      });
    } else {
      setState(() {
        _results = "Please enter an integer";
      });
    }
  }
}
