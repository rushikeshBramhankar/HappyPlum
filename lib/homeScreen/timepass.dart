import 'package:flutter/material.dart';

class Timepass extends StatefulWidget {
  const Timepass({super.key});

  @override
  State<Timepass> createState() => _TimepassState();
}

class _TimepassState extends State<Timepass> with TickerProviderStateMixin {
  late AnimationController _treeController;
  late AnimationController _zoomController;
  late Animation<double> _treeAnimation;
  late Animation<double> _zoomAnimation;

  // Separate AnimationControllers for each plum text fade-in
  late AnimationController _firstTextController;
  late AnimationController _secondTextController;
  late AnimationController _thirdTextController;

  late Animation<double> _firstTextOpacityAnimation;
  late Animation<double> _secondTextOpacityAnimation;
  late Animation<double> _thirdTextOpacityAnimation;

  bool _showFirstPlum = false;
  bool _showSecondPlum = false;
  bool _showThirdPlum = false;
  bool _showBaby = false; // Initially hide the baby image
  bool _showThinkingContainer = false; // Initially hide the thinking container

  @override
  void initState() {
    super.initState();

    // Tree animation
    _treeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _treeAnimation = Tween<double>(begin: 1.0, end: 1.2)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_treeController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _treeController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _treeController.forward();
        }
      });

    // Zoom animation for plums
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _zoomAnimation = Tween<double>(begin: 1.0, end: 1.1)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_zoomController);

    // Fade-in animation for text containers
    _firstTextController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _secondTextController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _thirdTextController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _firstTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _firstTextController, curve: Curves.easeIn),
    );

    _secondTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _secondTextController, curve: Curves.easeIn),
    );

    _thirdTextOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _thirdTextController, curve: Curves.easeIn),
    );

    // Start tree animation
    _treeController.forward();

    // Delayed appearance of plums and their text containers with increased delay
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showFirstPlum = true;
        _firstTextController.forward();
        _showBaby = true; // Baby appears after the first plum
      });

      // Show the thinking container 2 seconds after the first plum appears
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _showThinkingContainer = true;
        });
      });
    });

    Future.delayed(const Duration(seconds: 6), () {
      // Increased delay
      setState(() {
        _showSecondPlum = true;
        _secondTextController.forward();
      });
    });

    Future.delayed(const Duration(seconds: 9), () {
      // Increased delay
      setState(() {
        _showThirdPlum = true;
        _thirdTextController.forward();
      });
    });
  }

  @override
  void dispose() {
    _treeController.dispose();
    _zoomController.dispose();
    _firstTextController.dispose();
    _secondTextController.dispose();
    _thirdTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: const Center(
          child: Text(
            'MAGIC PLUM TREE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              // Animated Tree
              Center(
                child: AnimatedBuilder(
                  animation: _treeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _treeAnimation.value,
                      child: child,
                    );
                  },
                  child: Image.asset(
                    'assets/tree.png',
                    height: 390,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Plum Images Row with appearance animation and zoom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _showFirstPlum
                      ? buildPlumColumn('Bonjour', _firstTextOpacityAnimation)
                      : const SizedBox.shrink(),
                  _showSecondPlum
                      ? buildPlumColumn('早上好', _secondTextOpacityAnimation)
                      : const SizedBox.shrink(),
                  _showThirdPlum
                      ? buildPlumColumn('buen día', _thirdTextOpacityAnimation)
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 15),
              // Baby image appears after the first plum
              if (_showBaby)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 2, 20, 20),
                    child: Image.asset(
                      'assets/baby.png',
                      height: 200,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              // Thinking container appears after 2 seconds
              if (_showThinkingContainer)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.yellow[200],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Text(
                    "Let's learn the greeting today!!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Plum column with text container and zoom animation
  Column buildPlumColumn(String text, Animation<double> textOpacityAnimation) {
    return Column(
      children: [
        // Plum image with zoom animation
        ScaleTransition(
          scale: _zoomAnimation,
          child: Center(
            child: Image.asset(
              'assets/plum.png',
              height: 120,
            ),
          ),
        ),
        const SizedBox(height: 15),
        // Text container with individual fade-in animation
        FadeTransition(
          opacity: textOpacityAnimation,
          child: Container(
            height: 50,
            width: 100,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 111, 190, 114),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
