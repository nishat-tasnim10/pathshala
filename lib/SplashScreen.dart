import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pathshala/main.dart';

import 'WelcomeScreen.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}
class _SplashScreenState extends State<SplashScreen> {
  bool show1st=true;

  double offsetX=0.0;
  Timer?shakeTimer;


  @override
  void initState() {
    //initialized
    super.initState();
    StartAnimations();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>Welcomescreen ()),
      );
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        show1st=false;
        offsetX=0.0;
      });
      shakeTimer?.cancel();
    });

  }

  void StartAnimations() {
    final random = Random();
    shakeTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        offsetX = random.nextDouble() * 20 - 10;
      });
    });
  }
  @override
  void dispose(){
    shakeTimer?.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: show1st
                ?[
              Color(0xFF132E35), // Dark bluish green
              //  Color(0xFFFED7A5), // Soft pastel peach
              Color(0xFF9BA8AB), // soft grey-blue
              Color(0xFF1F4B4F), // Slightly lighter blackish green
            ]
                : [
              //Color(0xFF132E35), // Dark bluish-green
              // Color(0xFFFED7A5), // Soft pastel peach
              Color(0xFF9BA8AB), // soft grey-blue
              Color(0xFF1F4B4F), // Slightly lighter blackish green
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),




        child: Center(

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  //1st

                  AnimatedOpacity(
                    opacity: show1st ? 1 : 0, duration:const Duration(milliseconds: 600),
                    child: Transform.translate(
                      offset:Offset(offsetX,0),
                      child:  Image.asset("assets/images/boy.png",width: 270,),
                    ),
                  ),
                  //2nd


                  AnimatedRotation(
                    turns: show1st ? -0.1 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    child: AnimatedOpacity(
                      opacity: show1st ? 0 : 1,
                      duration: const Duration(milliseconds: 600),
                      child: Image.asset("assets/images/teacher.png", width: 290),
                    ),
                  ),
                ],
              ),


              const SizedBox(height:70),
              AnimatedOpacity(
                opacity: show1st ? 0 : 1,
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Pathshala",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,
                      color: Color(0xFFFED7A5)),
                ),
              )
            ],
          ),

        ),
      ),


    );

  }

}
