import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'dart:math';

class MemoryGameScreen extends StatefulWidget {
  @override
  _MemoryGameScreenState createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<String> _cardImages = [
    'assets/baby.png',
    'assets/happy.jpg',
    'assets/plum.png',
    'assets/tree.png', // Pairs
    'assets/baby.png',
    'assets/happy.jpg',
    'assets/plum.png',
    'assets/tree.png',
  ];

  List<bool> _flippedCards = [];
  List<bool> _matchedCards = [];
  int? _firstFlippedIndex;
  int? _secondFlippedIndex;

  bool _showRedOverlay = false;
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer(); // Initialize audio player

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }

  void _initializeGame() {
    _cardImages.shuffle();
    _flippedCards = List.generate(_cardImages.length, (index) => false);
    _matchedCards = List.generate(_cardImages.length, (index) => false);
    _firstFlippedIndex = null;
    _secondFlippedIndex = null;
  }

  void _flipCard(int index) {
    setState(() {
      if (_matchedCards[index]) return;

      _flippedCards[index] = true;

      if (_firstFlippedIndex == null) {
        _firstFlippedIndex = index;
      } else if (_secondFlippedIndex == null) {
        _secondFlippedIndex = index;

        Future.delayed(Duration(seconds: 1), () {
          _checkMatch();
        });
      }
    });
  }

  void _checkMatch() async {
    if (_firstFlippedIndex != null && _secondFlippedIndex != null) {
      if (_cardImages[_firstFlippedIndex!] ==
          _cardImages[_secondFlippedIndex!]) {
        setState(() {
          _matchedCards[_firstFlippedIndex!] = true;
          _matchedCards[_secondFlippedIndex!] = true;
        });
        _confettiController.play();

        // Play audio for correct match
        await _audioPlayer.play(AssetSource('a1.mp3'));
      } else {
        _flashRedOverlay(); // Flash red overlay if no match
        setState(() {
          _flippedCards[_firstFlippedIndex!] = false;
          _flippedCards[_secondFlippedIndex!] = false;
        });

        // Play audio for incorrect match
        await _audioPlayer.play(AssetSource('a2.mp3'));
      }
      _firstFlippedIndex = null;
      _secondFlippedIndex = null;
    }
  }

  void _flashRedOverlay() {
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        _showRedOverlay = !_showRedOverlay;
      });
      if (timer.tick >= 4) {
        timer.cancel();
        setState(() {
          _showRedOverlay = false;
        });
      }
    });
  }

  Path _drawFlower(Size size) {
    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(0, 0), radius: 4));
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Image.asset(
                'assets/logohappy.jpg',
                height: 60,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Memory Matching Game',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 0.2),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _cardImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!_flippedCards[index]) {
                      _flipCard(index);
                    }
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: _flippedCards[index] || _matchedCards[index]
                        ? Image.asset(_cardImages[index], fit: BoxFit.cover)
                        : Container(
                            color: Colors.blueAccent,
                            child: Center(
                              child: Text(
                                '?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter, // Start confetti from the top
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality
                  .explosive, // Spread confetti in all directions
              particleDrag: 0.05, // Optional drag to slow down particles
              emissionFrequency: 0.78,
              numberOfParticles: 500,
              gravity: 0.9, // Adjust gravity for desired fall speed
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: _drawFlower,
            ),
          ),
          if (_showRedOverlay)
            Container(
              color: Colors.red.withOpacity(0.5),
            ),
        ],
      ),
    );
  }
}
