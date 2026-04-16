import 'package:flutter/material.dart';
import 'package:pathshala/SigninPage.dart';
import 'dart:async';
import 'LoginPage.dart';
import 'SigninPage.dart';

class Welcomescreen  extends StatelessWidget{
  const  Welcomescreen ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[
              Color(0xFF132E35),
              // Color(0xFFFED7A5),
              Color(0xFF9BA8AB),
              Color(0xFF1F4B4F),
            ],
          ),
        ),
        child:Center(
            child: Column(
                children: [
                  const SizedBox(height: 40,),
                  const Text("Welcome",textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 42,fontWeight:FontWeight.bold,height :3,
                        fontStyle:FontStyle.normal,color: Color(0xFFFED7A5),
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Color(0xFFFED7A5),
                            offset: Offset(0, 0),
                          ),
                        ]
                    ),
                  ),

                  const SizedBox(height: 30),


                  SizedBox(
                    width: 500,
                    height: 260,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Left image
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/welcome1.png',
                            width: 220,
                            height: 220,
                          ),
                        ),
                        // Right image
                        Positioned(
                          right: 0,
                          bottom: 70, // higher than left image
                          child: Image.asset(
                            'assets/images/lady.png',
                            width: 220,
                            height: 220,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /* Padding(padding: const EdgeInsets.symmetric(horizontal:40),
               child:TextField(
                  decoration: InputDecoration(hintText: "login",enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)), gapPadding: 4.0,
                      borderSide:BorderSide(color:Colors.transparent,width:1,style: BorderStyle.solid,)
                  ),
                  filled:true,fillColor: Color(0x22FFFFFF),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFFED7A5),), borderRadius: const BorderRadius.all(Radius.circular(40.0)), gapPadding: 4.0)
                  ),
                )
           )*/

                  const Spacer(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child:SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F4B4F),
                          foregroundColor: const Color(0xFFFED7A5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical:16), // height
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFFFED7A5),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height :16),
                  Padding(
                      padding:const EdgeInsets.symmetric(horizontal: 40),
                      child:SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SigninPage()),
                              );
                            }, style: ElevatedButton.styleFrom(
                          foregroundColor: const Color(0xFFFED7A5),backgroundColor: Color(0xFF1F4B4F),
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical:16),
                        ),
                            child: const Text("sign in",style: TextStyle(
                                color:Color(0xFFFED7A5),fontSize: 20,fontWeight: FontWeight.bold),
                            )
                        ),
                      )

                  ),

                  const SizedBox(height: 100),





                ]



            )
        ),






      ),
    );


  }

}