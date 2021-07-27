import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calculator/history_screen.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    onCreateDataBase();
  }

  Color red = Color(0xfff37b7c);
  Color backgroundDark = Color(0xff22252d);
  Color buttonBackgroundDark = Color(0xff2a2d37);
  Color textColorDark = Color(0xFFEEEEEE);
  Color greenDark = Color(0xff2d7d70);
  Color backgroundLight = Color(0xfff9f9f9);
  Color buttonBackgroundLight = Color(0xFFEEEEEE);
  Color textColorLight = Color(0xff000000);
  Color greenLight = Color(0xff53d3bf);

  int buttonFlex = 2;
  double buttonSize = 80;
  String equation = "0";
  String expression = "0";
  String result = "0";

  var equationController = TextEditingController();
  var resultController = TextEditingController();
  late Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: isLight ? backgroundLight : backgroundDark,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isLight ? greenLight : greenDark,
                ),
                width: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        isLight ? Icons.light_mode : Icons.dark_mode,
                        color: isLight ? Colors.white : Colors.black,
                      ),
                      onPressed: () => (setState(() {
                        isLight = !isLight;
                      })),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      equation,
                      style: TextStyle(
                          fontSize: 45,
                          color: isLight ? textColorLight : textColorDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      result,
                      style: TextStyle(
                          fontSize: 40,
                          color: isLight ? textColorLight : textColorDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: buttonFlex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildNumberButton(
                          "AC", isLight ? greenLight : greenDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: buildSymbolButton(
                            "%", isLight ? greenLight : greenDark)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: buildSymbolButton(
                            "⌫", isLight ? greenLight : greenDark)),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: buildSymbolButton(
                            "÷", isLight ? greenLight : greenDark)),
                  ],
                ),
              ),
              Expanded(
                flex: buttonFlex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildNumberButton(
                          "7", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "8", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "9", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildSymbolButton(
                        "×",
                        isLight ? greenLight : greenDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: buttonFlex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildNumberButton(
                          "4", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "5", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "6", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildSymbolButton(
                          "+", isLight ? greenLight : greenDark),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: buttonFlex,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: buildNumberButton(
                          "1", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "2", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildNumberButton(
                          "3", isLight ? textColorLight : textColorDark),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: buildSymbolButton(
                          "-", isLight ? greenLight : greenDark),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: buttonFlex,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: buildIconButton(
                            Icons.history, isLight ? greenLight : greenDark),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildNumberButton(
                            "0", isLight ? textColorLight : textColorDark),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildNumberButton(
                            ".", isLight ? textColorLight : textColorDark),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: buildSymbolButton(
                            "=", isLight ? greenLight : greenDark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberButton(String val, Color color) {
    return MaterialButton(
      onPressed: () {
        buttonPressed(val);
      },
      child: Text(
        val,
        style:
            TextStyle(fontSize: 25, color: color, fontWeight: FontWeight.bold),
      ),
      color: isLight ? buttonBackgroundLight : buttonBackgroundDark,
      elevation: 1,
      height: 80,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget buildSymbolButton(String val, Color color) {
    return MaterialButton(
      onPressed: () {
        buttonPressed(val);
      },
      child: Text(
        val,
        style: TextStyle(
          fontSize: 30,
          color: color,
        ),
      ),
      color: isLight ? buttonBackgroundLight : buttonBackgroundDark,
      elevation: 1,
      height: buttonSize,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget buildIconButton(IconData iconData, Color color) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryScreen(),
            ),
          );
        });
      },
      child: Icon(
        iconData,
        color: color,
        size: 30,
      ),
      color: isLight ? buttonBackgroundLight : buttonBackgroundDark,
      elevation: 1,
      height: buttonSize,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      }
      else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      }
      else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          insertDataBase(equation, result);
        } catch (e) {
          result = "Error";
        }
      }
      else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
      /*
      else if(buttonText == "1" || buttonText == "2" || buttonText == "3"
          || buttonText == "4" || buttonText == "5" || buttonText == "6"
          || buttonText == "7" || buttonText == "8" || buttonText == "9"
          || buttonText == "0" ){
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      }*/
    });
  }

  void onCreateDataBase() async {
    database = await openDatabase(
      'history.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
                'CREATE TABLE calcHistory (id INTEGER PRIMARY KEY, equation TEXT, result TEXT)')
            .then((value) {
          print('Database Created');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database).then((value) {
          setState(() {
            data = value;
          });
        });
        print('database opened');
      },
    );
  }

  Future insertDataBase(String equation, String result) async {
    return await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO calcHistory (equation, result) VALUES ("$equation","$result")')
          .then((value) {
        print("Data inserted");
      }).catchError((error) {
        print("Error while inserting Data${error.toString()}");
      });
      return null;
    });
  }

  Future<List<Map>> getDataFromDataBase(database) async {
    return await database.rawQuery('SELECT * FROM calcHistory');
  }
}
