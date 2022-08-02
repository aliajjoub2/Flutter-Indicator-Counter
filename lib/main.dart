// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterDownApp(),
    );
  }
}

class CounterDownApp extends StatefulWidget {
  const CounterDownApp({Key? key}) : super(key: key);

  @override
  State<CounterDownApp> createState() => _CounterDownAppState();
}

class _CounterDownAppState extends State<CounterDownApp> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 1);
  bool isRunning = false;

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (qqq) {
      setState(() {
        int neuSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: neuSeconds);
        if (neuSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 1);
            isRunning = false;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promodoro App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  progressColor: Color.fromARGB(255, 255, 85, 113),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  lineWidth: 7,
                  percent: duration.inSeconds / 60,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  radius: 120.0,
                  center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style: TextStyle(fontSize: 77, color: Color.fromARGB(255, 6, 6, 6)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            isRunning
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (repeatedFunction!.isActive) {
                              setState(() {
                                repeatedFunction!.cancel();
                              });
                            } else {
                              startTimer();
                            }
                          },
                          child: Text(
                              repeatedFunction!.isActive ? 'Stop' : 'Resume')),
                             const SizedBox(
                                width: 20,
                              ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              repeatedFunction!.cancel();
                              isRunning = false;
                              duration = Duration(minutes: 1);
                            });
                          },
                          child: Text('cancel')),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    child: Text('Start')),
                     Padding(
              padding: EdgeInsets.all(15.0),
              child:  LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animateFromLastPercent: true,
                animationDuration: 1000,
                percent: duration.inSeconds / 60,
                center: Text(
                    "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style: TextStyle(fontSize: 11, color: Color.fromARGB(255, 6, 6, 6)),
                  ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
