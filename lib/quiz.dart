import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedOptionIndex = -1;
  int currentQuestionIndex = 0;

  // ✅ FULL QUESTION LIST (8 Biology Questions)
  List<Map<String, dynamic>> questions = [
    {
      "question": "What is the basic unit of life?",
      "options": ["Atom", "Molecule", "Cell", "Tissue"],
      "answer": 2
    },
    {
      "question": "Which organelle is known as the powerhouse of the cell?",
      "options": ["Nucleus", "Mitochondria", "Ribosome", "Chloroplast"],
      "answer": 1
    },
    {
      "question": "Which gas do plants absorb from the atmosphere?",
      "options": ["Oxygen", "Carbon dioxide", "Nitrogen", "Hydrogen"],
      "answer": 1
    },
    {
      "question": "What carries genetic information?",
      "options": ["RNA", "DNA", "Protein", "Enzyme"],
      "answer": 1
    },
    {
      "question": "Which blood cells help fight infection?",
      "options": ["Red blood cells", "White blood cells", "Platelets", "Plasma"],
      "answer": 1
    },
    {
      "question": "What is the largest organ in the human body?",
      "options": ["Heart", "Liver", "Skin", "Brain"],
      "answer": 2
    },
    {
      "question": "Which system controls body activities?",
      "options": ["Digestive", "Nervous", "Respiratory", "Circulatory"],
      "answer": 1
    },
    {
      "question": "What is photosynthesis?",
      "options": [
        "Process of breathing",
        "Process of making food in plants",
        "Digestion in animals",
        "Blood circulation"
      ],
      "answer": 1
    },
  ];

  @override
  Widget build(BuildContext context) {
    var currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // ✅ APP BAR
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Biology Quiz",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // 🔹 Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / questions.length,
                  minHeight: 6,
                  backgroundColor: Colors.teal.shade200,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "Question ${currentQuestionIndex + 1} of ${questions.length}",
                  style: const TextStyle(fontSize: 14),
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 Question Box
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  currentQuestion["question"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // 🔹 Options
              ...List.generate(
                currentQuestion["options"].length,
                    (index) {
                  return Column(
                    children: [
                      buildOption(
                        index,
                        currentQuestion["options"][index],
                      ),
                      const SizedBox(height: 15),
                    ],
                  );
                },
              ),

              const Spacer(),

              // 🔹 Next Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: selectedOptionIndex == -1
                      ? null
                      : () {
                    if (currentQuestionIndex < questions.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        selectedOptionIndex = -1;
                      });
                    } else {
                      // ✅ Finished Quiz
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Quiz Finished"),
                          content: const Text(
                            "You have completed the Biology Quiz!",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Option Widget
  Widget buildOption(int index, String text) {
    bool isSelected = selectedOptionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOptionIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}