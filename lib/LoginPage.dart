import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'HomePage.dart';

class LoginPage extends  StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool hidePassword = true;

  var emailText = TextEditingController();
  var passText = TextEditingController();

  @override
  void dispose(){
    emailText.dispose();
    passText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Login In", style: TextStyle(color: Color(0xFFFED7A5))),
          backgroundColor:Color(0xFF132E35),leading: IconButton.filled(onPressed: ()=> Navigator.pop(context),
        icon: Icon(Icons.arrow_back,color: Color(0xFFFED7A5)),
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

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 6),
                        child: Text(
                          "EMAIL OR USERNAME",
                          style: TextStyle(
                            color: Color(0xFFFED7A5),
                            fontSize: 11,
                            letterSpacing: 1.8,
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
                            hintText: "Enter email or username",
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
                            fontSize: 11,
                            letterSpacing: 1.8,
                            fontWeight: FontWeight.w600,
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
                      onPressed: ()  async {
                        String email = emailText.text.trim();
                        String password = passText.text.trim();

                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please enter username and password",
                                style: TextStyle(color: Color(0xFFFED7A5)),
                              ),
                              backgroundColor: Color(0xFF132E35),
                            ),
                          );
                          return;
                        }
                        try{
                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        } on FirebaseAuthException catch(e){
                          String msg="Login Failed !";
                          if(e.code=='user-not-found') msg="No account Found";
                          if(e.code=='wrong-password') msg="Incorrect Password";
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
                        "Login",
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