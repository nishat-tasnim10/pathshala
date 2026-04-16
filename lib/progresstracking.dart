import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pathsala/quiz.dart';
import 'overallprogresscard.dart';

class ProgressTrackerScreen extends StatelessWidget {
  const ProgressTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,

        title: const Text(
          "Study Progress Tracker",
          style: TextStyle(
            color: Color(0xFF1E4F8F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Color(0xFF1E4F8F)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(),
                ),
              );
            },
          ),
        ],


      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            //
            Text(
              "Hello,USER!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              "Here's your study progress",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 25),

            OverallProgressCard(),

            SizedBox(height: 25),


            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
