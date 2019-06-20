import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(UselessApp());
}

class UselessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Color(0xFFeceff1),
        canvasColor: Color(0xffffffff),
        primaryColor: Color(0xFFeceff1),
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(
                title: TextStyle(
                    fontFamily: 'Dimitri', color: Colors.black, fontSize: 30))),
        buttonTheme: ButtonThemeData(
            height: 100,
            minWidth: 100,
            buttonColor: Color(0xffffffff),
            textTheme: ButtonTextTheme.primary,
            splashColor: Colors.black26,
            shape: CircleBorder(
                side: BorderSide(
                    color: Color(0xFFeceff1),
                    width: 10,
                    style: BorderStyle.solid))),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  Timer _timer;
  Text buttonText = Text('TAP ME');
  bool isButtonDisabled = false;
  int _start = 10;
  double tapcount = 0, flag = 0;
  double pbottom = 100, pleft = 100, pright = 100, ptop = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TAP APP'),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              right: 150,
              left: 150,
              child: Text(
                'Count= ${tapcount}',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Positioned(
              top: ptop,
              bottom: pbottom,
              left: pleft,
              right: pright,
              child: RaisedButton(
                onPressed: isButtonDisabled
                    ? () {
                        buttonText = Text('TIME UP',style: TextStyle(color: Colors.red),);
                        setState(() {});
                      }
                    : () {
                        if (flag == 0) {
                          startTimer();
                          flag = 1;
                        } else if (flag == 2) {
                          isButtonDisabled = true;
                        }
                        tapcount++;
                        Random r = new Random();
                        double rangeMin = 0, rangeMax = 150;
                        ptop = rangeMin + (300 - rangeMin) * r.nextDouble();
                        pbottom = rangeMin + (300 - rangeMin) * r.nextDouble();
                        pleft =
                            rangeMin + (rangeMax - rangeMin) * r.nextDouble();
                        pright =
                            rangeMin + (rangeMax - rangeMin) * r.nextDouble();
                        setState(() {});
                      },
                child: buttonText,
              ),
            )
          ],
        ));
  }

  startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
            () {
              if (_start < 1) {
                timer.cancel();
                flag = 2;
              } else {
                _start = _start - 1;
              }
              print('${_start}');
            },
          ),
    );
  }
}
