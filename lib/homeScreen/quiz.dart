import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart'; // Import the confetti package
import 'dart:math';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestionIndex = 0;
  String? selectedOption;
  bool? isCorrect;
  late ConfettiController _confettiController;

  List<Map<String, dynamic>> questions = [
    {
      'questionImage':
          'https://images.pexels.com/photos/1598377/pexels-photo-1598377.jpeg?auto=compress&cs=tinysrgb&w=400', // Replace with your actual URL
      'options': ['Elephant', 'Lion', 'Tiger', 'Bear'],
      'correctAnswer': 'Lion',
    },
    {
      'questionImage':
          'https://images.pexels.com/photos/302304/pexels-photo-302304.jpeg?auto=compress&cs=tinysrgb&w=400', // Replace with your actual URL
      'options': ['Elephant', 'Lion', 'Tiger', 'Bear'],
      'correctAnswer': 'Tiger',
    },
  ];

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkAnswer(String option) {
    String correctAnswer = questions[currentQuestionIndex]['correctAnswer'];
    setState(() {
      selectedOption = option;
      isCorrect = (option == correctAnswer);
    });

    String message =
        isCorrect! ? 'Good job! Correct answer' : 'Ohh wrong answer! Try again';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );

    if (isCorrect!) {
      // Trigger confetti animation if the answer is correct
      _confettiController.play();
      Future.delayed(const Duration(seconds: 2), () {
        if (currentQuestionIndex < questions.length - 1) {
          setState(() {
            currentQuestionIndex++;
            selectedOption = null;
            isCorrect = null;
          });
        } else {
          // Reset quiz or show completion message
          setState(() {
            currentQuestionIndex = 0;
            selectedOption = null;
            isCorrect = null;
          });
        }
      });
    } else {
      // If the answer is wrong, reset the selection but stay on the same question
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectedOption = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String questionImage = questions[currentQuestionIndex]['questionImage'];
    List<String> options = questions[currentQuestionIndex]['options'];

    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Animal Quiz',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    questionImage,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 50),
                ...options.map((option) {
                  bool isSelected = option == selectedOption;
                  Color backgroundColor = isSelected
                      ? (isCorrect! ? Colors.green : Colors.red)
                      : Colors.white;
                  Color textColor = isSelected ? Colors.white : Colors.black;

                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        tileColor: backgroundColor,
                        title: Center(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                        onTap: selectedOption == null
                            ? () {
                                checkAnswer(option);
                              }
                            : null, // Disable selection after an option is chosen
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          // Confetti widget for animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2, // direction to go down
              particleDrag: 0.05, // slows down the confetti
              emissionFrequency: 0.05, // how often it emits
              numberOfParticles: 100, // number of particles to emit
              gravity: 0.3, // gravity
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: _drawFlower, // A custom shape of flower
            ),
          ),
        ],
      ),
    );
  }

  // Custom path for flower-like confetti particles
  Path _drawFlower(Size size) {
    final Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(0, 0),
        radius: 6)); // Example shape (circle as flower petal)
    return path;
  }
}
