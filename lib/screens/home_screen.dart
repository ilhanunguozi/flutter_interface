import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int totalSeconds = 1500;
  bool isRunning = false;

  var titleController = TextEditingController();

  // late 나중에 초기화 한다는 변수
  late Timer timer;

  String formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2,7);
  }

  void onTick(Timer timer) {
    setState(() {
      totalSeconds = totalSeconds - 1;
    });
  }

  void onStartPressed() {
      isRunning = true;
      timer = Timer.periodic(
            Duration(seconds: 1), onTick
      );
      setState(() {
        isRunning = true;
      });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRecyclingPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      totalSeconds = int.parse(titleController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                    formatTimer(totalSeconds)
                  , style: TextStyle(color: Theme.of(context).cardColor, fontSize: 90, fontWeight: FontWeight.w600)
                ),
              )
          ),
          Flexible(
              flex:1,
              child: TextField(
                  controller: titleController,
                  style: TextStyle(color: Colors.white),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: InputDecoration(
                    hoverColor: Colors.white,
                    border: OutlineInputBorder(),
                    labelText: '타이머',

                  ),

              )
          ),
          Flexible(
              flex: 1,
              child: Center(
                child: IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  icon: Icon( isRunning ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded),
                  onPressed: isRunning ? onPausePressed : onStartPressed,
                ),
              )
          ),
          Flexible(
              flex: 1,
              child: Center(
                child: IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  icon: Icon(Icons.recycling_rounded),
                  onPressed: onRecyclingPressed,
                ),
              )
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(0),top: Radius.circular(50))
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pomodors',style: TextStyle(
                              fontSize: 20 , fontWeight: FontWeight.w600
                              ,color: Theme.of(context).textTheme.headline1!.color)),
                          Text('0',style: TextStyle(
                              fontSize: 58 , fontWeight: FontWeight.w600
                              ,color: Theme.of(context).textTheme.headline1!.color)),
                        ],
                      ),
                    ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
