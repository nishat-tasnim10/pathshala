import 'package:flutter/material.dart';
import 'package:pathshala/HomePage.dart';
import 'package:pathshala/main.dart';
import 'WelcomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool hidePassword = true;

  var nameText = TextEditingController();
  var passText = TextEditingController();
  var emailText=TextEditingController();

  void dispose() {
    nameText.dispose();
    passText.dispose();
    emailText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Sign in", style: TextStyle(color: Color(0xFFFED7A5))),
          backgroundColor:Color(0xFF132E35),leading: IconButton.filled(onPressed: ()=> Navigator.pop(context),
        icon: Icon(Icons.arrow_back,color: Colors.white,),
      )
      ),
      body: Stack(
        children: [


          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF132E35).withOpacity(0.90),
                  Color(0xFF0D2329).withOpacity(0.99),

                  Color(0xFF0D2329).withOpacity(0.90) ,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                const SizedBox(height: 20),

                // ── Email / Username field ────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          "EMAIL",
                          style: TextStyle(
                            color: Color(0xFFFED7A5),
                            fontSize: 14,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: TextField(
                          controller: emailText,
                          style: TextStyle(color: Color(0xFFFED7A5), fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Enter email ",
                            hintStyle: TextStyle(
                              color: Color(0xFFFED7A5).withOpacity(0.35),
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(Icons.alternate_email,
                                color: Color(0xFFFED7A5).withOpacity(0.5), size: 20),
                            filled: true,
                            fillColor: Color(0xFF132E35).withOpacity(0.85),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFFFED7A5).withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFF4ECDC4),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),




                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(padding: const EdgeInsets.only(left:4,bottom :6),
                        child: Text(
                          " USERNAME",
                          style: TextStyle(
                            color: Color(0xFFFED7A5),
                            fontSize: 14,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: TextField(
                          controller: nameText,
                          style: TextStyle(color: Color(0xFFFED7A5), fontSize: 16),
                          decoration: InputDecoration(
                            hintText: " Enter username",
                            hintStyle: TextStyle(
                              color: Color(0xFFFED7A5).withOpacity(0.35),
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(Icons.person_outline_rounded,
                                color: Color(0xFFFED7A5).withOpacity(0.5), size: 20),
                            filled: true,
                            fillColor: Color(0xFF132E35).withOpacity(0.85),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFFFED7A5).withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFF4ECDC4),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),







                const SizedBox(height: 20),

                // ── Password field ────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          "PASSWORD",
                          style: TextStyle(
                            color: Color(0xFFFED7A5),
                            fontSize: 14,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 56,
                        width: double.infinity,
                        child: TextField(
                          controller: passText,
                          obscureText: hidePassword,
                          style: TextStyle(color: Color(0xFFFED7A5), fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            hintStyle: TextStyle(
                              color: Color(0xFFFED7A5).withOpacity(0.35),
                              fontSize: 15,
                            ),
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                                color: Color(0xFFFED7A5).withOpacity(0.5), size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(
                                hidePassword
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                color: Color(0xFFFED7A5).withOpacity(0.5),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Color(0xFF132E35).withOpacity(0.85),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFFFED7A5).withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(
                                color: Color(0xFF4ECDC4),
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async{
                        String username = nameText.text.trim();
                        String password = passText.text.trim();
                        String email=emailText.text.trim();

                        if (username.isEmpty || password.isEmpty || email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter E mail and password",
                                style: TextStyle(color: Color(0xFFFED7A5)),
                              ),
                              backgroundColor: Color(0xFF132E35),
                            ),
                          );
                          return;
                        }
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } on FirebaseAuthException catch (e) {
                          String msg="Sign In Failed !";
                          if(e.code=='weak-password') msg="Password must be at least 6 characters";
                          if(e.code=='email-already-in-use') msg="Email already exists";
                          if(e.code=='invalid-email') msg="invaild Email";
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(msg,

                                style: TextStyle(color: Color(0xFFFED7A5)),
                              ),
                              backgroundColor: Color(0xFF132E35),
                            ),
                          );
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F4B4F),
                        foregroundColor: const Color(0xFFFED7A5),
                        elevation: 4,
                        shadowColor: Color(0xFF4ECDC4).withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: Color(0xFF4ECDC4).withOpacity(0.35),
                            width: 1.5,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color(0xFFFED7A5),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                Spacer(flex: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }
}