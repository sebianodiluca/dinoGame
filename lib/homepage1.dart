import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  double velox = 0.01;
  int record = 0;
  int score = 0;
  double ostacoloX = 1;
  bool ostacoloSuperato = false;
  bool stop = false;
  bool avviaOstacolo = true;
  bool staSaltando = false;
  double altezza = 0;
  double tempo = 0;
  double tempo1 = 0;
  double accelerazione = 9;
  double dinosauroY = 1;
  double dinosauroX = -0.5;
  var random = new Random();
  bool secondoOstacolo = false;
  double yPosizione = 0;
  double b = 0;
  double aspetta = 0;
  var _myDuration = const Duration(seconds: 1);
  double _myOpacity = 0.0;
  double velocita = 5.5;

  start() {
    avviaOstacolo = false;
    setState(() {
      score = 0;
      ostacoloX = 1;
      dinosauroY = 1;
    });
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      stop ? {timer.cancel(), stop = false} : null;
      if (((ostacoloX > -0.5 && ostacoloX < -0.2) && dinosauroY > 0.2)) {
        timer.cancel();
        stopGioco();
      } else if (((ostacoloX > -0.5 && ostacoloX < -0.2) && dinosauroY > 0.6)) {
        altezza = 0;
        tempo = 0;
        timer.cancel();
        stopGioco();
      }
      loopOstacolo();
      setState(() {
        ostacoloX -= velox;
      });
    });
  }

  void loopOstacolo() {
    setState(() {
      if (ostacoloX <= -1.2) {
        secondoOstacolo = new Random().nextBool();
        yPosizione = 2 * new Random().nextDouble();
        ostacoloX = 1.2;
        score++;
        ostacoloSuperato = true;
        velox += 0.001;
      }
    });
  }

  stopGioco() {
    aspetta = 0;
    setState(() {
      if (record < score) {
        setState(() {
          record = score;
        });
      }
      stop = true;
    });
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      aspetta += 0.2;
      if (aspetta > 1) {
        timer.cancel();
        start();
      }
    });
  }

  void salta() {
    altezza = 0;
    dinosauroY = 1;
    tempo = 0;
    staSaltando = true;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (1 - altezza > 1) {
          timer.cancel();
        } else
          dinosauroY = 1 - altezza;
      });
      tempo += 0.01;
      altezza = -accelerazione / 2 * tempo * tempo + velocita * tempo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: salta,
      onTap: start,
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          title: Center(
            child: Text(
              '404 Google Play ',
              style: TextStyle(
                color: Colors.grey[5],
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        child: Center(
                          child: Text(
                            (!stop) ? 'S t a r t' : 'G a m e  O v e r',
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Text(
                          'P u n t e g g i o: $score',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment(dinosauroX, dinosauroY),
                        child: Container(
                          height: 100,
                          // MediaQuery.of(context).size.height * 2 / 3 * 0.5 / 2,
                          width: 100,
                          // MediaQuery.of(context).size.width * 0.2 / 2,
                          child: AnimatedOpacity(
                            duration: _myDuration,
                            opacity: (stop) ? _myOpacity : 1,
                            child: Image.asset(
                              'lib/images/dino.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment(ostacoloX, 1),
                        child: Container(
                            height: 100,
                            width: 100,
                            child: AnimatedOpacity(
                                duration: _myDuration,
                                opacity: (stop) ? _myOpacity : 1,
                                child: Image.asset(
                                  'lib/images/cactus.png',
                                  fit: BoxFit.fill,
                                ))),
                      ),
                      Container(
                        alignment: Alignment(
                            (secondoOstacolo)
                                ? ostacoloX + 0.1
                                : ostacoloX - 0.2,
                            yPosizione - 1),
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'lib/images/nuvole.png',
                              fit: BoxFit.fill,
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              height: 250,
              color: Colors.green[400],
              child: Center(
                child: Text(
                  'RECORD : $record',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                  ),
                ),
              ),
            )),
          ],
        ),
        drawer: Container(
          width: 250,
          color: Colors.grey[600],
          child: Center(
            child: Text(
              'Created by Coderpillar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
